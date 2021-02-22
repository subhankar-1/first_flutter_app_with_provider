import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/HomePage.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: null),
      home: new SearchList(),
    );
  }
}

