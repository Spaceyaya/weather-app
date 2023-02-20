import 'package:flutter/material.dart';

class WeatherModel {
  String? country;
  String? cityName;
  String? weatherStateName;
  String? date;
  double? avgTemp;
  double? maxTemp;
  double? minTemp;

  void setData(var data) {
    country = data['location']['country'];
    cityName = data['location']['name'];

    weatherStateName =
        data['forecast']['forecastday'][0]['day']['condition']['text'];
    date = data['location']['localtime'];
    minTemp = data['forecast']['forecastday'][0]['day']['mintemp_c'];
    maxTemp = data['forecast']['forecastday'][0]['day']['maxtemp_c'];
    avgTemp = data['forecast']['forecastday'][0]['day']['avgtemp_c'];
  }

  String? GetImage() {
    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
      return 'assets/images/clear.png';
    } else if (weatherStateName == 'Cloudy' || weatherStateName == 'Cloudy') {
      return 'assets/images/cloudy.png';
    } else if (weatherStateName == 'Heavy rain' ||
        weatherStateName == 'Heavy rain') {
      return 'assets/images/rainy.png';
    } else if (weatherStateName == 'Moderate snow' ||
        weatherStateName == 'Moderate snowModerate snow') {
      return 'assets/images/snow.png';
    } else if (weatherStateName == 'Patchy light rain with thunder' ||
        weatherStateName == 'Patchy light rain with thunder') {
      return 'assets/images/thunderstorm.png';
    } else
      'assets/images/cloudy.png';
  }

  MaterialColor? GetThemeColor() {
    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
      return Colors.orange;
    } else if (weatherStateName == 'Cloudy' || weatherStateName == 'Cloudy') {
      return Colors.grey;
    } else if (weatherStateName == 'Heavy rain' ||
        weatherStateName == 'Heavy rain') {
      return Colors.blue;
    } else if (weatherStateName == 'Moderate snow' ||
        weatherStateName == 'Moderate snowModerate snow') {
      return Colors.blue;
    } else if (weatherStateName == 'Patchy light rain with thunder' ||
        weatherStateName == 'Patchy light rain with thunder') {
      return Colors.blue;
    } else
      Colors.black;
  }
}
