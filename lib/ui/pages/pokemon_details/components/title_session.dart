import 'package:flutter/material.dart';

class TitleSession extends StatelessWidget {
  final String title;
  TitleSession({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.green,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
