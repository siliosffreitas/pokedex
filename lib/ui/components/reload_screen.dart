import 'package:flutter/material.dart';

class ReloadScreenPage extends StatelessWidget {
  ReloadScreenPage({
    @required this.error,
    @required this.reload,
  });

  final String error;
  final Future<void> Function() reload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error,
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Recarregar'),
            onPressed: reload,
          ),
        ],
      ),
    );
  }
}
