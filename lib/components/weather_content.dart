import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/size_config.dart';

class WeatherContent extends StatelessWidget {
  WeatherContent({this.temperature, this.image, this.day});
  final int temperature;
  final String image;
  final String day;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0),
      child: Column(
        children: [
          Text(
            '$temperature°',
            style: TextStyle(fontSize: 90.0),
          ),
          Image.asset(
            image,
            width: getScreenWidth(270),
            height: getScreenHeight(300),
          ),
          Text(
            '$day',
            style: kTextLabel,
          )
        ],
      ),
    );
  }
}
