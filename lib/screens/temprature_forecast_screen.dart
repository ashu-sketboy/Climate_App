import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class TempratureForecastScreen extends StatelessWidget {
  final String city;
  final List forecastData;
  final DateTime date = DateTime.now();

  int _count = 0;

  TempratureForecastScreen({@required this.city, @required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesome5Solid.arrow_left,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  Text(
                    city,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20),
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Next 3 Days",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 25,
                      color: Colors.white,
                    ),
              ),
            ),
            ...forecastData.map((element) {
              String day = DateFormat('EEEE').format(
                date.add(
                  Duration(days: _count),
                ),
              );

              _count += 1;
              return Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(
                            "${element.maxTemp}",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${element.minTemp}',
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Image.network("http:${element.imgUrl}")),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
