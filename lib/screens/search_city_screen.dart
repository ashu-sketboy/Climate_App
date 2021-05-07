import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import './temprature_overview_screen.dart';

class SearchCityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode _fNode = new FocusNode();
    String _value = '';

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey,
            Colors.blueGrey[900],
          ], begin: Alignment.topRight, end: Alignment.bottomCenter),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                alignment: Alignment.topCenter,
                child: TextField(
                  focusNode: _fNode,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    icon: Icon(FontAwesome5Solid.search_location,
                        color: _fNode.hasFocus
                            ? Colors.black
                            : Colors.blueGrey[900]),
                    labelText: "City/State/Country",
                    labelStyle: TextStyle(
                      color:
                          _fNode.hasFocus ? Colors.black : Colors.blueGrey[900],
                    ),
                    focusedBorder: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  onChanged: (str) {
                    _value = str;
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return TempratureOverviewScreen(city: _value);
                  }));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey[900],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Show Weather Detail",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
