import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class databaseConection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Visualización camas"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("camasOcupadas")
              .document("ocupadas")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var camasOcupadas = snapshot.data;
            return new Card(
              child: SizedBox(
                width: phoneWidth,
                height: phoneHeight/3,
                child: Text(
                  camasOcupadas["ocupadas"].toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
