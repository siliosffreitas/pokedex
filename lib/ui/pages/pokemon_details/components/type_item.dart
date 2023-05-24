import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class TypeItem extends StatelessWidget {
  final TypeViewModel viewModel;

  const TypeItem({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(viewModel.name,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
