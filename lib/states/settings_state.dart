import 'package:equatable/equatable.dart';

enum TemperatureUnit{
  fahrenheit,
  celsius
}

class SettingsState extends Equatable{
  final TemperatureUnit temperatureUnit;
  const SettingsState({required this.temperatureUnit}):
      assert(temperatureUnit != null);
  @override
  // TODO: implement props
  List<Object> get props => [];
}