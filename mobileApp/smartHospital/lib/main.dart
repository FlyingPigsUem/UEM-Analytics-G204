import 'package:flutter/material.dart';
import 'package:smartHospital/homePage/homePage.dart';
import 'package:smartHospital/loginPage.dart';

void main() => runApp(MyApp());

/// Starts the application and calls the HomePage class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hospital',
      home: LoginPage(),
    );
  }
}
