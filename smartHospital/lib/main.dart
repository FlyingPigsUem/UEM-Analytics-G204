
import 'package:flutter/material.dart';
import 'package:smartHospital/databaseConection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hospital',
      home: databaseConection(),
    );
  }
}