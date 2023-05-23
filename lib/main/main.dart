import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'factories/pages/pokemons/pokemons_page_factory.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final primaryColor = Color(0xFFDC0A2D);

    return GetMaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
          primaryColor: primaryColor,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          fontFamily: 'Poppins'),
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
