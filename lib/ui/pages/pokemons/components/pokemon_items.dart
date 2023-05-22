import 'package:flutter/material.dart';

import 'components.dart';

class PokemonItens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 3,
      children: <Widget>[
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
        PokemonItem(),
      ],
    );
  }
}
