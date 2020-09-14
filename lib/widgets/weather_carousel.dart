import 'package:flutter/material.dart';
import 'package:weather_app/components/weather_content.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/services/weather_forecast.dart';

class WeatherCarousel extends StatefulWidget {
  @override
  _WeatherCarouselState createState() => _WeatherCarouselState();
}

class _WeatherCarouselState extends State<WeatherCarousel> {
  WeatherModel weather = WeatherModel();
  List<ForecastModel> data = List<ForecastModel>();

  @override
  void initState() {
    super.initState();
    getWeatherData().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  Future<List<ForecastModel>> getWeatherData() async {
    dynamic weatherData = await WeatherModel().getWeatherByLocation();
    List<ForecastModel> weatherList = [];
    double temp;
    String day;
    String weatherDescription;
    String dateTime;
    String time;

    for (int i = 0; i < 5; i++) {
      temp = weatherData['list'][i]['main']['temp'];
      dateTime = weatherData['list'][i]['dt_txt'];
      day = convertDate(dateTime);
      time = getTime(dateTime);
      weatherDescription = weatherData['list'][0]['weather'][0]['description'];
      weatherList.add(
        ForecastModel(
          temperature: temp.toInt(),
          weatherSymbol: weather.getWeatherSymbold(weatherDescription),
          day: day,
          weatherDescription: weather.getWeatherIcon(weatherDescription),
          time: time,
        ),
      );
    }

    return weatherList;
  }

//Extract and convert number of day into actual day. e.g 1 => Monday
  String convertDate(String dateTime) {
    int dayNumber;
    String day;
    var date = DateTime.parse(dateTime);

    dayNumber = date.weekday;

    switch (dayNumber) {
      case 1:
        day = 'MONDAY';
        break;
      case 2:
        day = 'TUESDAY';
        break;
      case 3:
        day = 'WEDNESDAY';
        break;
      case 4:
        day = 'THURSDAY';
        break;
      case 5:
        day = 'FRIDAY';
        break;
      case 6:
        day = 'SATURDAY';
        break;
      case 7:
        day = 'SUNDAY';
        break;
      default:
        day = 'Error: Unknown Day';
    }
    return day;
  }

  //Extract hours from DateTime
  // ignore: missing_return
  String getTime(String dateTime) {
    var timeData = DateTime.parse(dateTime);
    int hour = timeData.hour;
    if (hour == 0) {
      hour = 12;
      return hour.toString() + 'AM';
    } else if (hour > 0 && hour < 12) {
      return hour.toString() + 'AM';
    } else if (hour > 12) {
      hour = hour - 12;
      return hour.toString() + 'PM';
    }
  }

  //Build page view slide with temperature, weather sign and time.
  int pageIndex = 0;
  AnimatedContainer _buildIconList(int index) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOut,
      height: 90.0,
      width: 50.0,
      decoration: BoxDecoration(
        color:
            pageIndex == index ? Colors.white : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data[index].time),
          SizedBox(
            height: 10.0,
          ),
          Icon(
            data[index].weatherDescription,
            size: 20.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text('${data[index].temperature}°'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
                itemCount: data.length,
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return WeatherContent(
                    temperature: data[index].temperature,
                    image: data[index].weatherSymbol,
                    day: data[index].day,
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data
                    .asMap()
                    .entries
                    .map((e) => _buildIconList(e.key))
                    .toList()),
          )
        ],
      ),
    );
  }
}
