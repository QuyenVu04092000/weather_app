import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  ThemeBloc():
     super(ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white));
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async*{
    ThemeState newThemeState;
    if(themeEvent is ThemeEventWeatherChanged){
      final weatherCondition = themeEvent.main;
      if(weatherCondition == 'Clear' ||
         weatherCondition == 'LightCloud') {
        newThemeState = ThemeState(backgroundColor: Colors.yellow, textColor: Colors.white);
      } else if(weatherCondition == 'Fog' ||
                weatherCondition == 'Atmosphere' ||
                weatherCondition == 'Rain' ||
                weatherCondition == 'Drizzle' ||
                weatherCondition == 'Mist' ||
                weatherCondition == 'HeavyCloud' ||
                weatherCondition == 'Dust' ||
                weatherCondition == 'Ash' ||
                weatherCondition == 'Sand'
      ) {
        newThemeState = ThemeState(backgroundColor: Colors.indigo, textColor:  Colors.white);
      } else if(weatherCondition == 'Snow'){
        newThemeState = ThemeState(backgroundColor: Colors.lightBlue, textColor:  Colors.white);
      } else if(weatherCondition == 'Thunderstorm'){
        newThemeState = ThemeState(backgroundColor: Colors.deepPurple, textColor:  Colors.white);
      } else {
        newThemeState = ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemeState;
    }
  }
}