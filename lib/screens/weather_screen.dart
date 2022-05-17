import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/screens/temperature_widget.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:weather_app/states/weather_state.dart';

import '../bloc/theme_bloc.dart';

class WeatherScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}
class _WeatherScreenState extends State<WeatherScreen>{
  late Completer<void> _completer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App using Flutter Bloc'),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                  )
                );
              },
              icon: Icon(Icons.settings)
          ),
          IconButton(
              onPressed: () async {
                final typedCity = await Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => CitySearchScreen(),
                        )
                      );
                  if(typedCity != null){
                    BlocProvider.of<WeatherBloc>(context).add(
                      WeatherEventRequested(city: typedCity)
                    );
                  }
                },
              icon: Icon(Icons.search)
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, weatherState){
                if(weatherState is WeatherStateSuccess){
                  BlocProvider.of<ThemeBloc>(context).add(
                      ThemeEventWeatherChanged(
                          main: weatherState.weather[0].main
                      )
                  );
                  _completer.complete();
                  _completer = Completer();
                }
              },
              builder: (context,weatherState) {
                if(weatherState is WeatherStateLoading) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if(weatherState is WeatherStateSuccess){
                  final weather = weatherState.weather;
                  final city = weatherState.city;
                  return BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, themeState){
                        return RefreshIndicator(
                          onRefresh: (){
                            BlocProvider.of<WeatherBloc>(context).add(
                                WeatherEventRefresh(city: city.name)
                            );

                            return _completer.future;
                          },
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: weather.length,
                            itemBuilder: (context,index){
                            final color = themeState.backgroundColor;
                            final Size = MediaQuery.of(context).size;
                              return Card(
                                elevation: 15,
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                    side: BorderSide(width: 5, color: Colors.black45)
                                ),

                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   gradient: LinearGradient(
                                  //     begin: Alignment.topCenter,
                                  //     end: Alignment.bottomCenter,
                                  //     stops: [0,10],
                                  //     colors: [
                                  //       color[800]!,
                                  //       color[400]!,
                                  //     ]
                                  //   )
                                  // ),
                                  child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: Size.height * 0.02
                                          ),
                                          Text(
                                            weather[index].lastUpdated,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.lightBlueAccent,
                                                decorationThickness: 4,
                                            ),
                                          ),
                                          TemperatureWidget(weather: weather, index: index,)
                                        ],
                                      ),
                                )


                              );
                            }
                          )
                        );
                      }
                  );
                }
                if(weatherState is WeatherStateFail){
                  return Text('Something went wrong',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16
                    ),
                  );
                }
                return Center(child: Text(
                  'Select a location first !',
                  style: TextStyle(fontSize: 30),
                ),
                );
              },
            ),
          ),
        ),
      )
    );
  }
}