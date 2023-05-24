import 'dart:async';

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

  StreamController<bool> isLoadingController;

  initStreams() {
    isLoadingController = StreamController<bool>();
  }

  mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
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
}
