import 'package:flutter/material.dart';
import 'package:pokedex/ui/pages/pokemons/components/view_models/view_models.dart';

class CustomAppBar extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;

  CustomAppBar({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    title: Text(
                      viewModel.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          viewModel.id,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image(
                      image: AssetImage('lib/ui/assets/Pokeball.png'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitWidth,
                      color: Colors.white.withAlpha(30),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.white,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 70),
          child: Image.network(
            viewModel.urlPhoto,
            width: 200,
          ),
        ),
      ],
    );
  }
}
