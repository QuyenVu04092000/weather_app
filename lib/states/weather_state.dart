import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';

import '../models/city.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class WeatherStateInitial extends WeatherState{}
class WeatherStateLoading extends WeatherState{}
class WeatherStateSuccess extends WeatherState{
  final List<Weather> weather;
  final City city;
  const WeatherStateSuccess({required this.weather, required this.city}):
      assert(weather != null),
      assert(city != null);
  @override
  // TODO: implement props
  List<Object> get props => [weather,city];
}
class WeatherStateFail extends WeatherState{
  
}