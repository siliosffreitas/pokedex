import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';
import 'package:provider/provider.dart';

import '../pokemon_view_model.dart';

class PokemonItem extends StatelessWidget {
  final PokemonViewModel viewModel;

  const PokemonItem({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);
    return Builder(
      builder: (BuildContext context) {
        presenter.loadDetails(viewModel);

        return GestureDetector(
          onTap: () => presenter.goToPokemonDetail(viewModel.id),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 55,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 45,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFEFEFEF),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '#004',
                            style: TextStyle(
                                fontSize: 8, color: Color(0xFF666666)),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Container(
                        child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/132.png',
                        ),
                      )),
                      Text(
                        viewModel.name,
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFF1D1D1D)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
