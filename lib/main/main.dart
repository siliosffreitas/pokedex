import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/components/app_theme.dart';

import 'factories/pages/pokemons/pokemons_page_factory.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Pokédex',
      theme: makeAppTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/pokemons',
      getPages: [
        GetPage(
            name: '/pokemons',
            page: makePokemonsPage,
            transition: Transition.fade),
      ],
    );
  }
}
