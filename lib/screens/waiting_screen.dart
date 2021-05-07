import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Text(
          "Hold on .....",
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
      ),
    );
  }
}
