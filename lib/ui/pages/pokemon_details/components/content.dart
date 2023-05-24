import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

import 'components.dart';

class Content extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  Content({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TypesItens(viewModel: viewModel),
            TitleSession(title: 'About'),
            About(viewModel: viewModel),
            TitleSession(title: 'Base Stats'),
            Stats(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}
