import 'package:equatable/equatable.dart';

class City extends Equatable{
  final String name;

//constructor
  const City ({
    required this.name,

  });
  @override
  List<Object> get props => [
    name
  ];
//convert from JSON to Weather object
  factory City.fromJson(dynamic jsonObject){
    return City(
      name: jsonObject['city']['name']

    );
  }

}