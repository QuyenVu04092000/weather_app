import 'package:equatable/equatable.dart';

class Weather extends Equatable{

  final String formattedCondition;
  final String main;
  final double feelsLike;
  final int humidity;
  final double temp;
  final double windSpeed;
  final int clouds;
  final String lastUpdated;

//constructor
  const Weather ({

    required this.formattedCondition,
    required this.main,
    required this.feelsLike,
    required this.humidity,
    required this.temp,
    required this.windSpeed,
    required this.clouds,
    required this.lastUpdated
  });
  @override
  List<Object> get props => [

    formattedCondition,
    feelsLike,
    humidity,
    temp,
    windSpeed,
    clouds,
    lastUpdated
  ];
//convert from JSON to Weather object
  factory Weather.fromJson(dynamic jsonObject){
    return Weather(

      formattedCondition: jsonObject['weather'][0]['description'].toString(),
      main:  jsonObject['weather'][0]['main'].toString(),
      feelsLike: jsonObject['main']['feels_like'] as double,
      humidity: jsonObject['main']['humidity'] as int,
      temp: jsonObject['main']['temp'] as double,
      windSpeed: jsonObject['wind']['speed'] as double,
      clouds: jsonObject['clouds']['all'] as int,
      lastUpdated: jsonObject['dt_txt'].toString()
    );
  }
}