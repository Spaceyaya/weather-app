import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/cubits/weatherCubit/weatherCubit.dart';
import 'package:weather/models/weatherMo.dart';
import 'package:weather/providers/weatherProvider.dart';
import 'package:weather/services/weatherServices.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 158, 36),
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              BlocProvider.of<WeatherCubit>(context)
                  .GetWeather(cityName: cityName!);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 35, horizontal: 16),
              label: Text(
                'Search',
                style: TextStyle(color: Color.fromARGB(255, 252, 158, 36)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 252, 158, 36),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 252, 158, 36),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              suffixIcon: GestureDetector(
                onTap: (() async {
                  WeatherService service = WeatherService();
                  WeatherModel? weather =
                      await service.getWeather(cityname: cityName!);

                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weather;
                  Navigator.pop(context);
                }),
                child: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 252, 158, 36),
                ),
              ),
              hintText: 'Search Your City',
            ),
          ),
        ),
      ),
    );
  }
}
