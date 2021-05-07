import 'package:flutter/material.dart';

class Climate {
  final String cityName;
  final double temp;
  final String condition;
  final String imgUrl;
  final double windSpeed;
  final double humid;
  final String time;
  final double minTemp;
  final double maxTemp;
  Icon icon;

  Climate(
      {this.cityName = "",
      @required this.condition,
      this.humid = 0,
      this.imgUrl = '',
      this.temp,
      this.windSpeed = 0,
      this.time,
      this.maxTemp = 0.0,
      this.minTemp = 0.0});
}
