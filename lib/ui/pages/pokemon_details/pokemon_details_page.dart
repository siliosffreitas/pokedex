import 'package:flutter/material.dart';

import 'components/components.dart';

class PokemonDetailsPage extends StatelessWidget {
  final String param;

  const PokemonDetailsPage(this.param);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 224,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Image(
                          image: AssetImage('lib/ui/assets/Pokeball.png'),
                          height: 224,
                          width: 224,
                          fit: BoxFit.fitWidth,
                          color: Colors.white.withAlpha(50),
                        ),
                      ),
                      Container(
                        height: 72,
                        child: Row(
                          children: [
                            IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {}),
                            Expanded(
                              child: Text(
                                param,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                '#001',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        TypesItens(),
                        TitleSession(title: 'About'),
                        About(),
                        TitleSession(title: 'Base Stats'),
                        Stats(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 80),
              child: Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png',
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
