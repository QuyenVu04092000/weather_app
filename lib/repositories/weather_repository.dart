//handle weather


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/weather.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
const apiKey = "2ee7d8f2d8765d13ea48e1a177f32cfa";
final locationUrl = (name) => '${baseUrl}?q=${name}&cnt=6&appid=${apiKey}';
class WeatherRepository{
  final http.Client httpClient;

  WeatherRepository({required this.httpClient}): assert(httpClient != null);

  //get weather from city id
  Future<List<Weather>> getWeatherFromCity(String name) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(name)));
    if(response.statusCode != 200){
      throw Exception('Error getting weather from location : ${name}');
    }
      final weatherjson = jsonDecode(response.body)['list'] as List;
      return weatherjson.map((e) => Weather.fromJson(e)).toList();
  }
  Future<City> getCityName(String name) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(name)));
    if(response.statusCode != 200){
      throw Exception('Error getting weather from location : ${name}');
    }
    final cityjson = jsonDecode(response.body);
    return City.fromJson(cityjson);
  }
}