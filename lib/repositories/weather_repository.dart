//handle weather


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
const apiKey = '2ee7d8f2d8765d13ea48e1a177f32cfa';
final locationUrl = (name) => 'api.openweathermap.org/data/2.5/forecast?q=${name}&cnt=6&appid=${apiKey}';
class WeatherRepository{
  final http.Client httpClient;

  WeatherRepository({required this.httpClient}): assert(httpClient != null);

  //get weather from city id
  Future<Weather> fetchWeather(String city) async {
    final response = await this.httpClient.get(locationUrl(city));
    if(response.statusCode == 200){
      final cities = jsonDecode(response.body) ;
      return Weather.fromJson(cities);
    } else {
      throw Exception('Error getting location id of : ${city}');
    }
  }

  Future<Weather> getWeatherFromCity(String city) {
    return fetchWeather(city);
  }
}