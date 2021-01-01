import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_hospital_web/addUserPage.dart';
import 'package:smart_hospital_web/patientCardWidget.dart';
import 'package:smart_hospital_web/userPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double phoneHeight = 200;
  final double phoneWidth = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),

        body: Column(children: [
      StreamBuilder(
          // ignore: deprecated_member_use
          stream: Firestore.instance
              .collection('usuarios')
              .orderBy("Alerta", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                      fontSize: 24));
            } else {
              return Expanded(
                child: Container(
                  child: ListView.builder(
                    itemExtent: 120,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => PatientCard(
                        phoneHeight: phoneHeight,
                        phoneWidth: phoneWidth,
                        document: snapshot.data.documents[index]),
                  ),
                ),
              );
            }
          }),
    ]));
  }
}

class UserPage {}
