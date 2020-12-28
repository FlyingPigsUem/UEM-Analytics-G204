import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_hospital/userListPage/vitalCardWidget.dart';

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
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Temperatura',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'ºC',
              vital: 'temperature',
              greenDownLimit: 36.2,
              greenUpLimit: 37.2,
              orangeDownLimit: 35.2,
              orangeUpLimit: 38.2,
              icon: 'assets/images/fever.png',
            ),
          
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Peso',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'kg',
              vital: 'weight',
              greenDownLimit: 70,
              greenUpLimit: 90,
              orangeDownLimit: 65,
              orangeUpLimit: 95,
              icon: 'assets/images/weight.png',
            ),
          
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Tensión arterial',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mmHg',
              vital: 'Tension Arterial',
              greenDownLimit: 70,
              greenUpLimit: 90,
              orangeDownLimit: 65,
              orangeUpLimit: 95,
              icon: 'assets/images/artTens.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Pulso',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'lpm',
              vital: 'Pulso',
              greenDownLimit: 60,
              greenUpLimit: 100,
              orangeDownLimit: 40,
              orangeUpLimit: 120,
              icon: 'assets/images/pulse.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Frec. respiratoria',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'rpm',
              vital: 'Respiraciones',
              greenDownLimit: 8,
              greenUpLimit: 25,
              orangeDownLimit: 5,
              orangeUpLimit: 30,
              icon: 'assets/images/respFrec.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'PV. auríc. dcha.',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'cm H2O',
              vital: 'Presión venosa auricula derecha',
              greenDownLimit: 0,
              greenUpLimit: 5,
              orangeDownLimit: 0,
              orangeUpLimit: 8,
              icon: 'assets/images/veinPres.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'PV. vena cava',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'cm H2O',
              vital: 'Presión venosa vena cava',
              greenDownLimit: 6,
              greenUpLimit: 12,
              orangeDownLimit: 3,
              orangeUpLimit: 15,
              icon: 'assets/images/veinPres.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Pres. pulmonar',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mmHg',
              vital: 'Presion pulmonar',
              greenDownLimit: 13,
              greenUpLimit: 16,
              orangeDownLimit: 10,
              orangeUpLimit: 25,
              icon: 'assets/images/respFrec.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Sat. venosa',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mmHg',
              vital: 'Saturacion venosa',
              greenDownLimit: 13,
              greenUpLimit: 16,
              orangeDownLimit: 10,
              orangeUpLimit: 25,
              icon: 'assets/images/veinSat.png',
            ),
           VitalCard(
              phoneWidth: phoneWidth,
              title: 'Saturación O2',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: '%',
              vital: 'Saturacion O2',
              greenDownLimit: 97,
              greenUpLimit: 98,
              orangeDownLimit: 98.4,
              orangeUpLimit: 97.4,
              icon: 'assets/images/o2SatCap.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Niv. glucemia',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mg/dl',
              vital: 'Niveles de Glucemia',
              greenDownLimit: 70,
              greenUpLimit: 105,
              orangeDownLimit: 60,
              orangeUpLimit: 115,
              icon: 'assets/images/glucose.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Capnografía',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mmHg',
              vital: 'Capnografía',
              greenDownLimit: 35,
              greenUpLimit: 45,
              orangeDownLimit: 30,
              orangeUpLimit: 50,
              icon: 'assets/images/o2SatCap.png',
            ),
          VitalCard(
              phoneWidth: phoneWidth,
              title: 'Pres. intracran.',
              phoneHeight: phoneHeight,
              document: document,
              magnitude: 'mmHg',
              vital: 'Presion Intracraneal',
              greenDownLimit: 10,
              greenUpLimit: 15,
              orangeDownLimit: 5,
              orangeUpLimit: 20,
              icon: 'assets/images/skull.png',
            ),
          
        ],
      ),
    );
  }
}
