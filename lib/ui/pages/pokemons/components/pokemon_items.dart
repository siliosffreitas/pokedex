import 'package:flutter/material.dart';

import '../pokemon_result_view_model.dart';
import 'components.dart';

class PokemonItens extends StatelessWidget {
  final PokemonsResultViewModel viewModel;

  const PokemonItens({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
        children: viewModel.pokemons
            .map<Widget>((v) => PokemonItem(viewModel: v))
            .toList()
              ..add(LoadNextPage()));
  }
}
