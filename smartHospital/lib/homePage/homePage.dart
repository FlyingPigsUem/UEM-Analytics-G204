import 'package:flutter/material.dart';
import 'package:smartHospital/addUser.dart';
import 'package:smartHospital/homePage/camasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/homePage/homeCardWidget.dart';
import 'package:smartHospital/colors.dart';

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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addUserPage()));
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
            Divider(
              color: Color.fromRGBO(255, 255, 255, 0.0),
            ),
            homeCardWidget(
                phoneWidth: phoneWidth,
                phoneHeight: phoneHeight,
                title: 'Pacientes',
                img: null)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'Hola',
              icon: Icon(
                Icons.home,
                color: colors.mainBlue,
              )),
          BottomNavigationBarItem(
              label: 'Hola', icon: Icon(Icons.access_alarm)),
          BottomNavigationBarItem(
            label: 'Hola',
            icon: Icon(Icons.business),
          ),
          BottomNavigationBarItem(
            label: 'Hola',
            icon: Icon(Icons.school),
          ),
        ],
      ),
    );
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
