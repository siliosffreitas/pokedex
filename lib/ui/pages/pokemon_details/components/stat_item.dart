import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final int value;

  const StatItem({@required this.value});

  String format(num n) {
    var a = n.toString().padLeft(3, '0');
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${format(value)}',
            style: TextStyle(color: Color(0xFF1D1D1D), fontSize: 10)),
        SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: value / 100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.green.withAlpha(100),
          ),
        )
      ],
    );
  }
}
