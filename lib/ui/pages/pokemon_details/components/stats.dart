import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

import 'components.dart';

class Stats extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  Stats({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 39,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'HP',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ATK',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'DEF',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SATK',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SDEF',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SPD',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.green,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // color: Colors.black,
          ),
          Container(
            width: 1,
            color: Color(0xFFE0E0E0),
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          Expanded(
              child: Container(
            child: Column(
              children: [
                Expanded(child: StatItem(value: int.parse(viewModel.hp))),
                Expanded(child: StatItem(value: int.parse(viewModel.attack))),
                Expanded(child: StatItem(value: int.parse(viewModel.defense))),
                Expanded(
                    child: StatItem(value: int.parse(viewModel.specialAttack))),
                Expanded(
                    child:
                        StatItem(value: int.parse(viewModel.specialDefense))),
                Expanded(child: StatItem(value: int.parse(viewModel.speed))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
