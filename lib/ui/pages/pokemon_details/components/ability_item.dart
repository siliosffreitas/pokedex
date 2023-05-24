import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class AbilityItem extends StatelessWidget {
  final AbilityViewModel viewModel;

  const AbilityItem({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      viewModel.name,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
