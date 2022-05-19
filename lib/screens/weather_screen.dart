import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/screens/temperature_widget.dart';
import 'package:weather_app/states/weather_state.dart';

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
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App using Flutter Bloc'),
        backgroundColor: Colors.lightBlueAccent,
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
              },
              builder: (context,weatherState) {
                if(weatherState is WeatherStateLoading) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if(weatherState is WeatherStateSuccess){
                  final weather = weatherState.weather;
                  final city = weatherState.city;
                  return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: weather.length,
                            itemBuilder: (context,index){
                            final Size = MediaQuery.of(context).size;
                              return Card(
                                  margin: EdgeInsets.only(top: 25,left: 10, right: 10),
                                  elevation: 15,
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                      side: BorderSide(width: 5, color: Colors.black45)
                                  ),
                                    child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: Size.height * 0.02
                                            ),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: Size.width * 0.03,
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/icons/time.svg",
                                                    height: Size.height * 0.035,
                                                    width: Size.width * 0.035,
                                                  ),
                                                  SizedBox(
                                                    width: Size.width * 0.02,
                                                  ),
                                                  Container(
                                                    width: Size.width * 0.78,
                                                      child: Text(
                                                        '${weather[index].lastUpdated} in ${city.name}' ,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: Colors.lightBlueAccent,
                                                          decorationThickness: 4,
                                                        ),
                                                      ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TemperatureWidget(weather: weather, index: index,)
                                          ],
                                        ),


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