import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

import 'components.dart';

class TypesItens extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  const TypesItens({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Center(
          child: ListView.separated(
        itemCount: viewModel.types.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 16),
        itemBuilder: (BuildContext context, int index) => TypeItem(
          viewModel: viewModel.types[index],
        ),
      )),
    );
  }
}
