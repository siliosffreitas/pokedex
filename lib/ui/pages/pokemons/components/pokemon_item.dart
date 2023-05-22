import 'package:flutter/material.dart';

class PokemonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                      style: TextStyle(fontSize: 8, color: Color(0xFF666666)),
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
                  'Charmander',
                  style: TextStyle(fontSize: 10, color: Color(0xFF1D1D1D)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
