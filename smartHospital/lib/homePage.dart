import 'package:flutter/material.dart';
import 'package:smartHospital/addUser.dart';
import 'package:smartHospital/camasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<int> _numCamas = countDocuments('usuarios');
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => addUserPage()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Visualización camas"),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            children: [
              camasCardWidget(
                  phoneWidth: phoneWidth,
                  phoneHeight: phoneHeight,
                  numeroCama: _numCamas),
            ],
          ),
        ));
  }

  Future<Null> _handleRefresh() async {
    Future<int> numAux = countDocuments('usuarios');
    setState(() {
      _numCamas = numAux;
    });
    return numAux;
  }
}

Future<int> countDocuments(String colection) async {
  QuerySnapshot _myDoc =
      await Firestore.instance.collection(colection).getDocuments();
  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  return (_myDocCount.length);
}
