import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

import 'components.dart';

class About extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  About({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('lib/ui/assets/weight.png'),
                      height: 12,
                      fit: BoxFit.fitWidth,
                      color: Color(0xFF1D1D1D),
                    ),
                    SizedBox(width: 10),
                    Text(
                      viewModel.weight,
                      style: TextStyle(
                        color: Color(0xFF1D1D1D),
                        fontSize: 10,
                      ),
                    )
                  ],
                )),
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 8, color: Color(0xFF666666)),
                )
              ],
            ),
          )),
          Container(width: 1, color: Color(0xFFE0E0E0)),
          Expanded(
              child: Container(
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('lib/ui/assets/height.png'),
                      height: 12,
                      fit: BoxFit.fitWidth,
                      color: Color(0xFF1D1D1D),
                    ),
                    SizedBox(width: 10),
                    Text(
                      viewModel.height,
                      style: TextStyle(
                        color: Color(0xFF1D1D1D),
                        fontSize: 10,
                      ),
                    )
                  ],
                )),
                Text(
                  'Height',
                  style: TextStyle(fontSize: 8, color: Color(0xFF666666)),
                )
              ],
            ),
          )),
          Container(width: 1, color: Color(0xFFE0E0E0)),
          Expanded(
              child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      children: viewModel.abilities
                          .map((ability) => AbilityItem(viewModel: ability))
                          .toList()),
                ),
                Text(
                  'Moves',
                  style: TextStyle(fontSize: 8, color: Color(0xFF666666)),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
