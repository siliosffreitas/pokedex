import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class PokemonsPresenterSpy extends Mock implements PokemonsPresenter {}

main() {
  PokemonsPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = PokemonsPresenterSpy();

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

  testWidgets('Should call load pokemons on load page',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
