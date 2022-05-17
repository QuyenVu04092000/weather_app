import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';

abstract class ThemeEvent extends Equatable{
  const ThemeEvent();
}
class ThemeEventWeatherChanged extends ThemeEvent{
 final String main;
  const ThemeEventWeatherChanged({required this.main}):
      assert(main != null);
  @override
  // TODO: implement props
  List<Object> get props => [main];
}