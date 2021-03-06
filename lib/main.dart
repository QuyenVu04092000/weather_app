import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_observer.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/weather_screen.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    httpClient: http.Client()
  );
  //create blocs
  runApp(
    BlocProvider(create: (context) => SettingsBloc(),
      child: DevicePreview(
              enabled: !kReleaseMode,
              builder: (context) => MyApp(weatherRepository: weatherRepository,), // Wrap your app
            ),
  ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  MyApp({Key? key, required this.weatherRepository}):
      assert(weatherRepository != null),
      super(key:key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      title: 'Flutter Weather App with Bloc',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}
