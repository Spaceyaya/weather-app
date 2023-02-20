import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/cubits/weatherCubit/weatherCubit.dart';
import 'package:weather/models/weatherMo.dart';
import 'package:weather/providers/weatherProvider.dart';
import 'package:weather/screens/searchPage.dart';

import '../cubits/weatherCubit/weatherStates.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocProvider.of<WeatherCubit>(context) == null
            ? Text('Weather App')
            : Text('Weather State'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is weatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is weatherSuccess) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    weatherData!.GetThemeColor()!,
                    weatherData!.GetThemeColor()![300]!,
                    weatherData!.GetThemeColor()![200]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    BlocProvider.of<WeatherCubit>(context).cityName.toString(),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    BlocProvider.of<WeatherCubit>(context)
                        .weatherModel!
                        .date
                        .toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(BlocProvider.of<WeatherCubit>(context)
                          .weatherModel!
                          .GetImage()
                          .toString()),
                      Text(
                        BlocProvider.of<WeatherCubit>(context)
                            .weatherModel!
                            .avgTemp
                            .toString(),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'MIN TEMP : ${weatherData!.minTemp}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Max TEMP : ${weatherData!.maxTemp}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    BlocProvider.of<WeatherCubit>(context)
                        .weatherModel!
                        .weatherStateName
                        .toString(),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            );
          } else if (State is weatherFailure) {
            return Center(
              child: Text('Something Went Wrong Please Try Again'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There's No Weather To Show 😔",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  Text(
                    "Search Now 🔍",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )
                ],
              ),
            );
          }
        },
      ),
      //Center(
      // child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // children: [
      // Text(
      // "There's No Weather To Show 😔",
      // style: TextStyle(fontSize: 25, color: Colors.black),
      //),
      // Text(
      // "Search Now 🔍",
      // style: TextStyle(fontSize: 25, color: Colors.black),
      // )
      // ],
      // ),
      // )
      // :
    );
  }
}
