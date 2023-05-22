import 'package:flutter/material.dart';

import 'components/components.dart';

class PokemonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDC0A2D),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 108,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage('lib/ui/assets/Pokeball.png'),
                            height: 24,
                            width: 24),
                        SizedBox(width: 16),
                        Image(
                            image: AssetImage('lib/ui/assets/Pokedex.png'),
                            height: 22),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 32,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.search, size: 16),
                                SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0xFF666666)),
                                  ),
                                ),
                                Icon(Icons.close, size: 16),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '#',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    ),
                  )
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
                child: PokemonItens(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
