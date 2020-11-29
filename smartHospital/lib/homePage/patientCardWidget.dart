import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
             width: 100.0,
             height: 100.0,
             decoration: new BoxDecoration(
               color: const Color(0xff7c94b6),
               image: new DecorationImage(
                 image: new NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                 fit: BoxFit.cover,
               ),
               borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
               border: new Border.all(
                 color: Colors.red,
                 width: 4.0,
               ),
             ),
           );
  }
}