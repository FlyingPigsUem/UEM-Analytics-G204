import 'package:flutter/material.dart';

import 'package:smartHospital/customWidgets/customTopBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/userListPage/vitalCardWidget.dart';

class UserPage extends StatelessWidget {
  UserPage({
    @required this.drName,
    @required this.drImgAsset,
    @required this.phoneWidth,
    @required this.phoneHeight,
    @required this.document,
  });
  final String drName;
  final String drImgAsset;
  final double phoneWidth;
  final double phoneHeight;
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: drName,
        img: drImgAsset,
        onPressed: null,
      ),
      body: ListView(
        children: [
          Text(document['name']),
          Hero(
            tag: 'Temperature',
            child: VitalCard(
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
          ),
          Hero(
            //cambiar valores green y orange
            tag: 'Peso',
            child: VitalCard(
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
          ),
          Hero(
            tag: 'Tension Arterial',
            child: VitalCard(
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
          ),
          Hero(
            tag: 'Pulse',
            child: VitalCard(
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
          ),
          Hero(
            //nota para la marina del futuro: vas por aquí, champion
            tag: 'Frecuencia respiratoria',
            child: VitalCard(
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
          ),Hero(
            //nota para la marina del futuro: vas por aquí, champion
            tag: 'PV aurícula derecha',
            child: VitalCard(
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
          ),
        ],
      ),
    );
  }
}
