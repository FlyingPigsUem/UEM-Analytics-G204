import 'package:flutter/material.dart';
import 'package:smart_hospital_web/homePage.dart';


void main() => runApp(MyApp());

/// Starts the application and calls the HomePage class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hospital',
      home: HomePage(),
    );
  }
}
