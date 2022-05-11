import 'package:equatable/equatable.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere, // dust, ash, fog, sand etc.
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class Weather extends Equatable{
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double maxTemp;
  final double temp;
  final int locationId;
  final String location;
  final String lastUpdated;
//constructor
  const Weather ({
    required this.weatherCondition,
    required this.formattedCondition,
    required this.minTemp,
    required this.maxTemp,
    required this.temp,
    required this.locationId,
    required this.location,
    required this.lastUpdated
  });
  @override
  List<Object> get props => [
    weatherCondition,
    formattedCondition,
    minTemp,
    maxTemp,
    temp,
    locationId,
    location,
    lastUpdated
  ];
//convert from JSON to Weather object
  factory Weather.fromJson(dynamic jsonObject){
    final list = jsonObject['List'][0];
    final cloudiness = list['clouds']['all'];
    return Weather(
      weatherCondition: _mapStringToWeatherCondition(list['weather']['description'],cloudiness),
      formattedCondition: list['weather']['description'] ?? '',
      minTemp: list['main']['temp_min'] ?? '',
      maxTemp: list['main']['temp_max'] ?? '',
      temp: list['main']['temp'] ?? '',
      locationId: jsonObject['city']['id'] as int,
      location:  jsonObject['city']['name'] ?? '',
      lastUpdated: list['dt_txt']
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString, int cloudiness){
    Map<String, WeatherCondition> map = {
      'Thunderstorm': WeatherCondition.thunderstorm,
      'Drizzle': WeatherCondition.drizzle,
      'Rain' : WeatherCondition.rain,
      'Snow' : WeatherCondition.snow,
      'Clear' : WeatherCondition.clear,
      'Clouds' : cloudiness >= 85 ? WeatherCondition.heavyCloud : WeatherCondition.lightCloud,
      'Mist' : WeatherCondition.mist,
      'fog' : WeatherCondition.fog,
      'Smoke' : WeatherCondition.atmosphere,
      'Haze' : WeatherCondition.atmosphere,
      'Dust' : WeatherCondition.atmosphere,
      'Sand' : WeatherCondition.atmosphere,
      'Ash' : WeatherCondition.atmosphere,
      'Squall' : WeatherCondition.atmosphere,
      'Tornado' : WeatherCondition.atmosphere
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
}