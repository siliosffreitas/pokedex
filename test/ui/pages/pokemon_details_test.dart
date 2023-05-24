import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/helpers/erros/ui_erros.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_page.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_presenter.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class PokemonDetailsPresenterSpy extends Mock
    implements PokemonDetailsPresenter {}

void main() {
  PokemonDetailsPresenter presenter;

  StreamController<bool> isLoadingController;
  StreamController<PokemonDetailsViewModel> loadPokemonDetailsController;

  initStreams() {
    isLoadingController = StreamController<bool>();
    loadPokemonDetailsController = StreamController<PokemonDetailsViewModel>();
  }

  mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.pokemonDetailsStream)
        .thenAnswer((_) => loadPokemonDetailsController.stream);
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = PokemonDetailsPresenterSpy();

    initStreams();
    mockStreams();

    final pokemonsPage = GetMaterialApp(
      initialRoute: '/pokemon/bulbasour',
      getPages: [
        GetPage(
            name: '/pokemon/:pokemon_name',
            page: () => PokemonDetailsPage(presenter: presenter)),
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
    loadPokemonDetailsController.close();
  }

  PokemonDetailsViewModel makePokemonsDetails() => PokemonDetailsViewModel(
        name: 'Pokémon 1',
        id: '#001',
        urlPhoto: faker.internet.httpUrl(),
        types: [
          TypeViewModel(
            name: 'grass',
            order: faker.randomGenerator.integer(100),
          ),
          TypeViewModel(
            name: 'poison',
            order: faker.randomGenerator.integer(100),
          ),
        ],
        weight: '6,9 kg',
        height: '0,7 m',
        abilities: [
          AbilityViewModel(name: 'ability 1'),
          AbilityViewModel(name: 'ability 2'),
        ],
        hp: '101',
        attack: '102',
        defense: '103',
        specialAttack: '104',
        specialDefense: '105',
        speed: '106',
      );

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call load pokemon details on load page',
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

  testWidgets('Should present error if loadPokemonDetailsStreams fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonDetailsController.addError(UIError.unexpected.description);
    await tester.pump();
    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsOneWidget);

    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Pokémon 1'), findsNothing);
  });

  testWidgets('Should present data if loadPokemonDetailsStreams success',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadPokemonDetailsController.add(makePokemonsDetails());
    await provideMockedNetworkImages(() async {
      await tester.pump();
    });
    expect(find.text('Algo errado aconteceu. Tente novamente mais tarde.'),
        findsNothing);

    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Pokémon 1'), findsOneWidget);
    expect(find.text('#001'), findsOneWidget);
    expect(find.text('grass'), findsOneWidget);
    expect(find.text('poison'), findsOneWidget);
    expect(find.text('6,9 kg'), findsOneWidget);
    expect(find.text('0,7 m'), findsOneWidget);
    expect(find.text('ability 1'), findsOneWidget);
    expect(find.text('ability 2'), findsOneWidget);
    expect(find.text('101'), findsOneWidget);
    expect(find.text('102'), findsOneWidget);
    expect(find.text('103'), findsOneWidget);
    expect(find.text('104'), findsOneWidget);
    expect(find.text('105'), findsOneWidget);
    expect(find.text('106'), findsOneWidget);
  });
}
