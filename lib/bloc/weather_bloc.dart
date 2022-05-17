import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

import '../models/city.dart';
import '../models/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}):
      assert(weatherRepository != null),
      super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if(weatherEvent is WeatherEventRequested){
      yield WeatherStateLoading();

        final List<Weather> weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        final City city = await weatherRepository.getCityName(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather,city: city);

    } else if(weatherEvent is WeatherEventRefresh){
      try{
        final List<Weather> weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        final City city = await weatherRepository.getCityName(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather, city: city);
      } catch (exception){
        yield WeatherStateFail();
      }
    }
  }
}