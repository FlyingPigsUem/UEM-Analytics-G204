import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:smart_hospital_web/userListPage/vitalCardWidget.dart';

class UserPage extends StatelessWidget {
  UserPage({
    @required this.phoneWidth,
    @required this.phoneHeight,
    @required this.document,
  });
  final double phoneWidth;
  final double phoneHeight;
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: (phoneHeight / 100) * 15,
                        height: (phoneHeight / 100) * 15,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: document['img'] != null
                                ? new NetworkImage(document['img'])
                                : AssetImage('assets/images/paciente.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Column(children: [
                    Align(alignment: Alignment.bottomLeft,
                                          child: Text(
                        'Edad: ' + document['age'].toString() + ' años',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli',
                            fontSize: 16),
                      ),
                    ),
                    Align(alignment:Alignment.bottomCenter,
                                          child: Text(
                        'Altura: ' + document['height'].toString() + ' cm',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli',
                            fontSize: 16),
                      ),
                    ),
                    Align(alignment: Alignment.bottomLeft,
                                          child: Text(
                        'Peso: ' + document['weight'][document['weight'].length - 1].toString() + ' kg',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli',
                            fontSize: 16),
                      ),
                    ),
                  ])
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    document['surName'] + ', ' + document['name'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Muli',
                        fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Cama ' + document['bedNum'].toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Muli',
                        fontSize: 14),
                  ),
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
}
