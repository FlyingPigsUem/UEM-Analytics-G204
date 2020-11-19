import 'package:flutter/material.dart';
import 'package:smartHospital/homePage/homePage.dart';
/*
Main class that builds the 'homePage' Page
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hospital',
      home: homePage(drName: 'Dra. Ruiz', drImgAsset: 'assets/images/Doctor Aux.png'),
    );
  }
}
