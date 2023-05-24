import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons_presenter.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class PokemonItens extends StatelessWidget {
  final PokemonsResultViewModel viewModel;

  const PokemonItens({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.searchStream,
        builder: (context, snapshot) {
          var pokemons = viewModel.pokemons
              .map<Widget>((v) => PokemonItem(viewModel: v))
              .toList();
          if (snapshot.data == null || snapshot.data.isEmpty) {
            pokemons.add(LoadNextPage());
          }
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 3,
            children: pokemons,
          );
        });
  }
}
