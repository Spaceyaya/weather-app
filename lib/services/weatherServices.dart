// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weatherMo.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'key=3a598488e34c45f28eb164416222506';
  Future<WeatherModel?> getWeather({required String cityname}) async {
    WeatherModel? weatherState;
    try {
      Uri url = Uri.parse(
        '$baseUrl/forecast.json?$apiKey&q=$cityname&days=1&aqi=no&alerts=no',
      );

      http.Response response = await http.get(url);
      var JsonData = jsonDecode(response.body);
      var data = JsonData['forecast']['forecastday'][0];

      //KHAIRY METHOD
      weatherState =  WeatherModel();
      weatherState.setData(JsonData);
    } catch (exception) {
      print('Wrong City Name');
    }
    return weatherState;
  }
}
