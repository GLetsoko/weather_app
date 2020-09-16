import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'location.dart';
import 'networking.dart';

const apiKey = '87637576533db340742002b244af22f8';
const url = 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getWeatherByLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$url?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherByCity() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$url?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // ignore: missing_return
  IconData getWeatherIcon(String weatherDescription) {
    if (weatherDescription == 'clear sky')
      return FontAwesomeIcons.sun;
    else if (weatherDescription == 'few clouds')
      return FontAwesomeIcons.cloudSun;
    else if (weatherDescription == 'scattered clouds')
      return FontAwesomeIcons.cloud;
    else if (weatherDescription == 'broken clouds')
      return FontAwesomeIcons.cloudMeatball;
    else if (weatherDescription == 'shower rain')
      return FontAwesomeIcons.cloudShowersHeavy;
    else if (weatherDescription == 'rain')
      return FontAwesomeIcons.cloudSunRain;
    else if (weatherDescription == 'thunderstorm')
      return FontAwesomeIcons.bolt;
    else if (weatherDescription == 'snow')
      return FontAwesomeIcons.snowflake;
    else if (weatherDescription == 'mist') return FontAwesomeIcons.smog;
  }

  String getWeatherSymbold(String weatherDescription) {
    switch (weatherDescription) {
      case 'clear sky':
        return 'assets/images/sunny.png';
      case 'few clouds':
        return 'assets/images/cloud_sun.png';
      case 'scatterd clouds':
        return 'assets/images/scattered_clouds.png';
      case 'broken clouds':
        return 'assets/images/clouds.png';
      case 'shower rain':
        return 'assets/images/cloud_rain.png';
      case 'rain':
        return 'assets/images/rain.png';
      case 'thumderstorm':
        return 'assets/images/thunderstorm.png';
      case 'snow':
        return 'assets/images/snowy.png';
      case 'mist':
        return 'assets/images/fog.png';
      default:
        return 'assets/images/cloud_sun.png';
    }
  }
}
