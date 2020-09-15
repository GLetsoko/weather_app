import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/weather_carousel.dart';

class WeatherScreen extends StatefulWidget {
  final weatherData;
  WeatherScreen({this.weatherData});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int temperature = 0;
  String cityName = '';
  var day;
  String weekDay;

  @override
  void initState() {
    getWeather(widget.weatherData);
    super.initState();
  }

  void getWeather(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        cityName = 'Unable to retrieve city name';
        return;
      }
      cityName = weatherData['city']['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Container(
                    child: Text(
                      cityName,
                      style: kTextLabel,
                    ),
                  ),
                ),
                WeatherCarousel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
