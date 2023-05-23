import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/pokemon_result_view_model.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class PokemonsPresenterSpy extends Mock implements PokemonsPresenter {}

main() {
  PokemonsPresenter presenter;

  StreamController<bool> isLoadingController;
  StreamController<PokemonsResultViewModel> loadPokemonsController;

  initStreams() {
    isLoadingController = StreamController<bool>();
    loadPokemonsController = StreamController<PokemonsResultViewModel>();
  }

  mockStreams() {
    when(presenter.pokemonsStream)
        .thenAnswer((_) => loadPokemonsController.stream);

    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
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
      ],
    );
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(pokemonsPage);
    });
  }

  closeStreams() {
    isLoadingController.close();
    loadPokemonsController.close();
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
}
