import 'package:flutter/cupertino.dart';

class ForecastModel {
  int temperature;
  String weatherSymbol;
  String day;
  IconData weatherDescription;
  String time;

  ForecastModel({
    this.temperature,
    this.weatherSymbol,
    this.day,
    this.weatherDescription,
    this.time,
  });
}
