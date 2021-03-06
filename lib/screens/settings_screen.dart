import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/settings_bloc.dart';
import 'package:weather_app/events/settings_event.dart';
import 'package:weather_app/states/settings_state.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState){
                  return ListTile(
                    title: Text('Temperature Unit'),
                    isThreeLine: true,
                    subtitle: Text(
                      settingsState.temperatureUnit == TemperatureUnit.celsius ?
                          'Celsius' : 'Fahrenheit'
                    ),
                    trailing: Switch(
                      value: settingsState.temperatureUnit == TemperatureUnit.celsius,
                      onChanged: (_) => BlocProvider.of<SettingsBloc>(context).
                        add(SettingsEventToggleUnit())
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}