import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../modules/climate_data_provider.dart';
import './temprature_forecast_screen.dart';
import './search_city_screen.dart';
import './waiting_screen.dart';

class TempratureOverviewScreen extends StatelessWidget {
  TempratureOverviewScreen({this.city = ''});

  final String city;

  @override
  Widget build(BuildContext context) {
    var climate = ClimateDataProvider(cityName: city);
    var _currentData = climate.currentDay;

    Color bgColor = Colors.white;

    void _changeBgColor(String condition) {
      if (condition.toLowerCase().contains('sunny') ||
          condition.toLowerCase().contains('clear')) {
        bgColor = Colors.orange.shade400;
      } else if (condition.toLowerCase().contains('partially cloudy') ||
          condition.toLowerCase().contains('cloudy') ||
          condition.toLowerCase().contains('overcast') ||
          condition.toLowerCase().contains('mist') ||
          condition.toLowerCase().contains('fog')) {
        bgColor = Colors.grey.shade800;
      } else if (condition.toLowerCase().contains('snow') ||
          condition.toLowerCase().contains('thundery') ||
          condition.toLowerCase().contains('drizzle')) {
        bgColor = Colors.blueGrey;
      } else {
        bgColor = Colors.blue.shade800;
      }
    }

    return FutureBuilder(
      future: _currentData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _changeBgColor(snapshot.data['current'].condition);
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bgColor.withOpacity(0.9), Colors.redAccent[100]],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchCityScreen();
                            },
                          ),
                        );
                      },
                    ),
                    title: Text(
                      snapshot.data['current'].cityName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        FontAwesome.calendar,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        print(snapshot.data['climateOfWeeks']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TempratureForecastScreen(
                                city: snapshot.data['current'].cityName,
                                forecastData: snapshot.data['forecastData']);
                          }),
                        );
                      },
                    ),
                  ),
                  Image.network(
                    'http:${snapshot.data['current'].imgUrl}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(snapshot.data['current'].condition),
                  Text(
                    "${snapshot.data['current'].temp}°",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesome5Solid.wind),
                      SizedBox(
                        width: 20,
                      ),
                      Text('${snapshot.data['current'].windSpeed}'),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...snapshot.data['climateOfDay'].map((element) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("${element.time.substring(0, 10)}"),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    color: Colors.white12,
                                  ),
                                  height: 180,
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${element.time.substring(10)}"),
                                      Image.network("http:${element.imgUrl}"),
                                      Text("${element.temp}°")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return WaitingScreen();
        }
      },
    );
  }
}
