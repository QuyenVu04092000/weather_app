import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}
class _WeatherScreenState extends State<WeatherScreen>{
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
        actions: <Widget>[
          IconButton(
              onPressed: (){
                //navigate to SettingScreen
              },
              icon: Icon(Icons.settings)
          ),
          IconButton(
              onPressed: () async {
                //Navigate to CitySearchScreen
              },
              icon: Icon(Icons.search)
          )
        ],
      ),
    );
  }
}