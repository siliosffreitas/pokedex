import 'package:flutter/material.dart';

import 'components.dart';

class About extends StatelessWidget {
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
                      '6,9kg',
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
                      '0,7m',
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
                    children: [
                      AbilityItem(),
                      AbilityItem(),
                    ],
                  ),
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
