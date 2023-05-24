import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_page.dart';
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_presenter.dart';

class PokemonDetailsPresenterSpy extends Mock
    implements PokemonDetailsPresenter {}

void main() {
  PokemonDetailsPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = PokemonDetailsPresenterSpy();

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

  testWidgets('Should call load pokemon details on load page',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
