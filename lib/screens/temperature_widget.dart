import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/settings_state.dart';

import '../bloc/theme_bloc.dart';
import '../states/theme_state.dart';

class TemperatureWidget extends StatelessWidget{
  final List<Weather> weather;
  final int index;
  //constructor
  TemperatureWidget({Key? key, required this.weather, required this.index}):
      assert(weather != null),
      assert(index != null),
      super(key: key);
  //convert celcisu to fahreheit
  int _toFahrenheit(double celsius) => ((celsius * 9/5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Weather: ${weather[index].main}, ${weather[index].formattedCondition}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        ),
                        Text('Temp: ${_formattedTemperature(weather[index].temp-273.15, settingsState.temperatureUnit)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                        Text('Feels Like: ${_formattedTemperature(weather[index].feelsLike-273.15, settingsState.temperatureUnit)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                        Text('Humidity: ${weather[index].humidity}%',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                        Text('Wind Speed: ${weather[index].windSpeed}m/s',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                        Text('Clouds: ${weather[index].clouds}%',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                      ],
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}