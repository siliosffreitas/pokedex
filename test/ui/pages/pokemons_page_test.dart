import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';

class PokemonsPresenterSpy extends Mock implements PokemonsPresenter {}

main() {
  PokemonsPresenter presenter;

  StreamController<bool> isLoadingController;

  initStreams() {
    isLoadingController = StreamController<bool>();
  }

  mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

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
}
