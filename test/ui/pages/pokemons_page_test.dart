import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemons/components/components.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class PokemonsPresenterSpy extends Mock implements PokemonsPresenter {}

main() {
  PokemonsPresenter presenter;

  StreamController<bool> isLoadingController;
  StreamController<PokemonsResultViewModel> loadPokemonsController;
  StreamController<String> navigateToController;
  StreamController<String> searchController;
  StreamController<Map<String, PokemonDetailsViewModel>>
      pokemonDetailsController;

  initStreams() {
    isLoadingController = StreamController<bool>();
    loadPokemonsController = StreamController<PokemonsResultViewModel>();
    navigateToController = StreamController<String>();
    searchController = StreamController<String>.broadcast();

    pokemonDetailsController =
        StreamController<Map<String, PokemonDetailsViewModel>>.broadcast();
  }

  mockStreams() {
    when(presenter.pokemonsStream)
        .thenAnswer((_) => loadPokemonsController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
    when(presenter.pokemonDetailsStream)
        .thenAnswer((_) => pokemonDetailsController.stream);
    when(presenter.searchStream).thenAnswer((_) => searchController.stream);
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

  Map<String, PokemonDetailsViewModel> makePokemonsDetails() => {
        'Pokémon 1': PokemonDetailsViewModel(
          name: faker.person.firstName(),
          id: '#001',
          urlPhoto: faker.internet.httpUrl(),
          types: [
            TypeViewModel(
              name: faker.lorem.word(),
              order: faker.randomGenerator.integer(100),
            ),
            TypeViewModel(
              name: faker.lorem.word(),
              order: faker.randomGenerator.integer(100),
            ),
          ],
          weight: '6,5 kg',
          height: '0,7 m',
          abilities: [
            AbilityViewModel(name: faker.lorem.word()),
            AbilityViewModel(name: faker.lorem.word()),
          ],
          hp: faker.randomGenerator.integer(100).toString(),
          attack: faker.randomGenerator.integer(100).toString(),
          defense: faker.randomGenerator.integer(100).toString(),
          specialAttack: faker.randomGenerator.integer(100).toString(),
          specialDefense: faker.randomGenerator.integer(100).toString(),
          speed: faker.randomGenerator.integer(100).toString(),
        ),
        'Pokémon 2': PokemonDetailsViewModel(
          name: 'Pokémon 2',
          id: '#002',
          urlPhoto: faker.internet.httpUrl(),
          types: [
            TypeViewModel(
              name: faker.lorem.word(),
              order: faker.randomGenerator.integer(100),
            ),
            TypeViewModel(
              name: faker.lorem.word(),
              order: faker.randomGenerator.integer(100),
            ),
          ],
          weight: '6,9 kg',
          height: '0,7 m',
          abilities: [
            AbilityViewModel(name: faker.lorem.word()),
            AbilityViewModel(name: faker.lorem.word()),
          ],
          hp: faker.randomGenerator.integer(100).toString(),
          attack: faker.randomGenerator.integer(100).toString(),
          defense: faker.randomGenerator.integer(100).toString(),
          specialAttack: faker.randomGenerator.integer(100).toString(),
          specialDefense: faker.randomGenerator.integer(100).toString(),
          speed: faker.randomGenerator.integer(100).toString(),
        ),
      };

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
    pokemonDetailsController.close();
    searchController.close();
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
    expect(find.text('A'), findsWidgets);
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

    verify(presenter.loadDetails(result.pokemons[0].name)).called(1);
    verify(presenter.loadDetails(result.pokemons[1].name)).called(1);
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
    verify(presenter.goToPokemonDetail('Pokémon 1')).called(1);
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

  testWidgets('Should present details if pokemonDetailsStream success',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());

    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    pokemonDetailsController.add(makePokemonsDetails());

    await provideMockedNetworkImages(() async {
      await tester.pumpAndSettle();
    });

    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsNothing);

    expect(find.text('Recarregar'), findsNothing);

    expect(find.text('Pokémon 1'), findsOneWidget);
    expect(find.text('#001'), findsOneWidget);

    expect(find.text('Pokémon 2'), findsOneWidget);
    expect(find.text('#002'), findsOneWidget);
  });

  testWidgets('Should show clean search button', (WidgetTester tester) async {
    final search = faker.randomGenerator.string(10);
    await loadPage(tester);

    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Search'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);

    searchController.add(search);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsOneWidget);

    searchController.add(null);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsNothing);

    searchController.add(search);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsOneWidget);

    searchController.add('');
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('Should call clearSearch on X button',
      (WidgetTester tester) async {
    final search = faker.randomGenerator.string(10);
    await loadPage(tester);

    searchController.add(search);
    await tester.pump();

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    verify(presenter.clearSearch()).called(1);
  });

  testWidgets('Should call search with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    await tester.pumpAndSettle();

    final termSearch = faker.lorem.word();
    await tester.enterText(find.bySemanticsLabel('Search'), termSearch);

    verify(presenter.search(termSearch)).called(1);
  });

  testWidgets('Should show the searched term', (WidgetTester tester) async {
    await loadPage(tester);

    final termSearch = faker.lorem.word();
    searchController.add(termSearch);
    await tester.pump();

    expect(tester.widget<TextField>(find.byType(TextField)).controller.text,
        termSearch);
  });

  testWidgets('Should show the searched term empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    final termSearch = '';
    searchController.add(termSearch);
    await tester.pump();

    expect(tester.widget<TextField>(find.byType(TextField)).controller.text,
        termSearch);
  });

  testWidgets('Should show the searched term null',
      (WidgetTester tester) async {
    await loadPage(tester);

    final termSearch = null;
    searchController.add(termSearch);
    await tester.pump();

    expect(
        tester.widget<TextField>(find.byType(TextField)).controller.text, '');
  });

  testWidgets('Should not show the LoadNextPage on search',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    final termSearch = faker.lorem.word();
    searchController.add(termSearch);
    await tester.pumpAndSettle();

    expect(find.byType(LoadNextPage), findsNothing);
  });

  testWidgets('Should call goToChangeSorting on sorting click',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonsController.add(makePokemons());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });

    await tester.tap(find.text('A'));
    verify(presenter.goToChangeSorting()).called(1);
  });
}
