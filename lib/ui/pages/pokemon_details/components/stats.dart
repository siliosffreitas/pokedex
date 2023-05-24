import 'package:flutter/material.dart';

import 'components.dart';

class Stats extends StatelessWidget {
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
                Expanded(child: StatItem(value: 30)),
                Expanded(child: StatItem(value: 54)),
                Expanded(child: StatItem(value: 34)),
                Expanded(child: StatItem(value: 76)),
                Expanded(child: StatItem(value: 90)),
                Expanded(child: StatItem(value: 23)),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
