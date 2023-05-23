import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';
import 'package:pokedex/ui/pages/pokemons/pokemons.dart';
import 'package:provider/provider.dart';

class PokemonItem extends StatelessWidget {
  final PokemonViewModel viewModel;

  const PokemonItem({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PokemonsPresenter>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Builder(
        builder: (BuildContext context) {
          presenter.loadDetails(viewModel);

          return GestureDetector(
            onTap: () => presenter.goToPokemonDetail(viewModel.id),
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
                      Expanded(
                        child: StreamBuilder<
                                Map<String, PokemonDetailsViewModel>>(
                            stream: presenter.pokemonDetailsStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data.containsKey(viewModel.name)) {
                                final pokemonDetailsModel =
                                    snapshot.data[viewModel.name];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          pokemonDetailsModel.id,
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFF666666)),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Image.network(
                                            pokemonDetailsModel.urlPhoto),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container(height: 0);
                            }),
                      ),
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
          );
        },
      ),
    );
  }
}
