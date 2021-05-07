import 'dart:convert';
import 'package:http/http.dart' as http;

import './climate.dart';
import './location_provider.dart';

class ClimateDataProvider {
  Map<String, dynamic> _climateData = {};
  final String _apiKey = '52fec354e0f04a5bafb121754210405';
  final String _authority = 'http://api.weatherapi.com/v1/forecast.json?';
  final cityName;

  ClimateDataProvider({this.cityName = ''});

  Future<String> _getDataByGeo() async {
    var location = await LocationProvider.getLocation();
    double lat = location['lat'];
    double lon = location['lon'];

    String str = '$lat,$lon';

    return str;
  }

  Future _getClimate({String city = ''}) async {
    String loc;
    if (city.isEmpty) {
      loc = await _getDataByGeo();
    } else {
      loc = city;
    }

    var response = await http.get(
        Uri.parse('${_authority}key=$_apiKey&q=$loc&days=7&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      var apiData = json.decode(response.body);

      Climate climate = Climate(
        cityName: '${apiData['location']['name']}',
        condition: '${apiData['current']['condition']['text']}',
        humid: apiData['current']['humidity'].toDouble(),
        imgUrl: '${apiData['current']['condition']['icon']}',
        temp: apiData['current']['temp_c'] as double,
        windSpeed: apiData['current']['wind_kph'] as double,
      );

      _climateData['current'] = climate;

      List climateList = [];

      for (int i = 0; i <= 23; i++) {
        climateList.add(Climate(
            condition:
                "${apiData['forecast']['forecastday'][0]['hour'][i]['condition']['text']}",
            temp: apiData['forecast']['forecastday'][0]['hour'][i]['temp_c'],
            time: '${apiData['forecast']['forecastday'][0]['hour'][i]['time']}',
            imgUrl:
                '${apiData['forecast']['forecastday'][0]['hour'][i]['condition']['icon']}'));
      }

      _climateData['climateOfDay'] = climateList;

      climateList = [];

      for (int i = 0; i <= 2; i++) {
        climateList.add(Climate(
          condition:
              "${apiData['forecast']['forecastday'][i]['day']['condition']['text']}",
          minTemp: apiData['forecast']['forecastday'][i]['day']['mintemp_c'],
          maxTemp: apiData['forecast']['forecastday'][i]['day']['maxtemp_c'],
          time: apiData['forecast']['forecastday'][i]['date'],
          imgUrl:
              "${apiData['forecast']['forecastday'][i]['day']['condition']['icon']}",
        ));
      }

      _climateData['climateOfWeeks'] = climateList;
    } else {
      print("Connection Error ${response.statusCode}");
    }

    return null;
  }

  // getters

  Future<Map<String, dynamic>> get currentDay async {
    await _getClimate(city: cityName);
    return {
      'current': _climateData['current'],
      'climateOfDay': _climateData['climateOfDay'],
      'forecastData': _climateData['climateOfWeeks']
    };
  }

  // Future<Map<String, dynamic>> get forecastData async {
  //   await _getClimate();
  //   return {'forecastData': _climateData['climateOfWeeks']};
  // }
}
