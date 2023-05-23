import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/components/components.dart';
import 'package:pokedex/ui/pages/pokemons/pokemon_result_view_model.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class PokemonsPresenterSpy extends Mock implements PokemonsPresenter {}

main() {
  PokemonsPresenter presenter;

  StreamController<bool> isLoadingController;
  StreamController<PokemonsResultViewModel> loadPokemonsController;
  StreamController<String> navigateToController;

  initStreams() {
    isLoadingController = StreamController<bool>();
    loadPokemonsController = StreamController<PokemonsResultViewModel>();
    navigateToController = StreamController<String>();
  }

  mockStreams() {
    when(presenter.pokemonsStream)
        .thenAnswer((_) => loadPokemonsController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  PokemonsResultViewModel makePokemons() => PokemonsResultViewModel(pokemons: [
        PokemonViewModel(
          name: 'Pokémon 1',
          url: faker.internet.httpUrl(),
          id: '1',
        ),
        PokemonViewModel(
          name: 'Pokémon 2',
          url: faker.internet.httpUrl(),
          id: '2',
        )
      ]);

  Future<void> loadPage(WidgetTester tester) async {
    presenter = PokemonsPresenterSpy();

    initStreams();
    mockStreams();

    final pokemonsPage = GetMaterialApp(
      initialRoute: '/pokemons',
      getPages: [
        GetPage(
            name: '/pokemons', page: () => PokemonsPage(presenter: presenter)),
        GetPage(
            name: '/any_route', page: () => Scaffold(body: Text('fake page'))),
      ],
    );
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(pokemonsPage);
    });
  }

  closeStreams() {
    isLoadingController.close();
    loadPokemonsController.close();
    navigateToController.close();
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call load pokemons on load page',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctely', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(null);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if loadPokemonsStreams fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.addError(UIError.unexpected.description);
    await tester.pump();
    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsOneWidget);

    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Pokémon 1'), findsNothing);
  });

  testWidgets('Should present list if loadPokemonsStreams success',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });
    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsNothing);

    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Pokémon 1'), findsWidgets);
    expect(find.text('Pokémon 2'), findsWidgets);
    expect(find.byType(LoadNextPage), findsOneWidget);
  });

  testWidgets('Should call load details on pokemon load',
      (WidgetTester tester) async {
    await loadPage(tester);

    final result = makePokemons();
    loadPokemonsController.add(result);
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });
    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsNothing);

    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Pokémon 1'), findsWidgets);
    expect(find.text('Pokémon 2'), findsWidgets);
    expect(find.byType(LoadNextPage), findsOneWidget);

    verify(presenter.loadDetails(result.pokemons[0])).called(1);
    verify(presenter.loadDetails(result.pokemons[1])).called(1);
  });

  testWidgets('Should call loadPokemons on LoadNextPage init',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should call loadPokemons on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.addError(UIError.unexpected.description);
    await tester.pump();

    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should call goToPokemonDetailPage on pokemon click',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    final button = find.text('Pokémon 1');
    await tester.tap(button);
    await tester.pump();
    verify(presenter.goToPokemonDetail('1')).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');

    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/pokemons');

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/pokemons');
  });
}
