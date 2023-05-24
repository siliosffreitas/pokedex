import 'package:flutter/material.dart';

import 'components/components.dart';

class PokemonDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(),
          Expanded(child: Content()),
        ],
      )),
    );
  }
}

class Content extends StatelessWidget {
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
            TypesItens(),
            TitleSession(title: 'About'),
            About(),
            TitleSession(title: 'Base Stats'),
            Stats(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Container(
              height: 224,
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    title: Text(
                      'Silio',
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
                          '#001',
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
                      height: 224,
                      width: 224,
                      fit: BoxFit.fitWidth,
                      color: Colors.white.withAlpha(50),
                    ),
                  ),

                  // Container(
                  //   height: 72,
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //           icon: Icon(Icons.arrow_back, color: Colors.white),
                  //           onPressed: () {}),
                  //       Expanded(
                  //         child: Text(
                  //           'Silio',
                  //           style: TextStyle(
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.w700,
                  //               color: Colors.white),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 24),
                  //         child: Text(
                  //           '#001',
                  //           style: TextStyle(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w700,
                  //               color: Colors.white),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
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
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png',
            width: 200,
          ),
        ),
      ],
    );
  }
}
