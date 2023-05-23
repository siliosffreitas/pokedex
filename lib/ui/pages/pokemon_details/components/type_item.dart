import 'package:flutter/material.dart';

class TypeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text('Grass',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
