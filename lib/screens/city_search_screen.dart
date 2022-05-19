import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CitySearchScreen();
}
class _CitySearchScreen extends State<CitySearchScreen>{
  final TextEditingController _cityTextController = TextEditingController();
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
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Enter a city'),
      ),
      body: SafeArea(
        child: Form(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: _cityTextController,
                      decoration: InputDecoration(
                        labelText: 'Enter a city',
                        hintText: 'Example: Chicago'
                      ),
                    ),
                  )
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pop(context, _cityTextController.text);
                  },
                  icon: Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}