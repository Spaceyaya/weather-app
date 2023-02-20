import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weatherCubit/weatherStates.dart';
import 'package:weather/models/weatherMo.dart';
import 'package:weather/services/weatherServices.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.weatherService) : super(weatherInitial());

  String? cityName;
  WeatherService weatherService;
  WeatherModel? weatherModel;
  void GetWeather({required String cityName}) async {
    emit(weatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityname: cityName);
      emit(weatherSuccess());
    } catch (e) {
      emit(weatherFailure());
    }
  }
}
