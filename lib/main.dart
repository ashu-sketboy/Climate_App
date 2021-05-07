import 'package:flutter/material.dart';

import './screens/temprature_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'regular',
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'regular', color: Colors.white),
          bodyText2:
              TextStyle(fontFamily: 'regular', fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
            fontFamily: 'num',
          ),
          subtitle2: TextStyle(fontFamily: 'num', fontSize: 70),
        ),
      ),
      home: SafeArea(child: TempratureOverviewScreen()),
    );
  }
}
