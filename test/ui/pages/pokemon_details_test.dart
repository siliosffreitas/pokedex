import 'dart:async';

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
}
