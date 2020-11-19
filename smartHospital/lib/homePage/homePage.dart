import 'package:flutter/material.dart';
import 'package:smartHospital/addUser.dart';
import 'package:smartHospital/homePage/camasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/homePage/homeCardWidget.dart';
import 'package:smartHospital/colors.dart';
import 'package:smartHospital/customTopBar.dart';
import 'package:smartHospital/userListPage.dart';

/*
homePage class corresponds to the first Page the user sees once logged in
It's a StatefulWidget because the number of beds changes on refresh 
*/
class homePage extends StatefulWidget {
  homePage({@required this.drName, @required this.drImgAsset});

  final String drName;
  final String drImgAsset;
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<int> _numCamas = countDocuments('usuarios');
  @override
  Widget build(BuildContext context) {
    /*
    phoneWidth--> Width of the phone the app is running
    phoneHeight--> Height of the phone the app is running

    These variables allow the app to be responsive
    */
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      /*
    The FAB makes the app navigate to the addUserPage
    */
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addUserPage()));
        },
        child: Icon(Icons.add),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: TopBar(
          title: widget.drName,
          img: widget.drImgAsset,
        ),
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
              img: 'assets/images/pacientes.jpg',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => userListPage(
                              drName: widget.drName,
                              drImgAsset: widget.drImgAsset,
                            )));
              },
            )
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
              label: 'Hola',
              icon: Icon(
                Icons.access_alarm,
                color: Colors.amber,
              )),
          BottomNavigationBarItem(
            label: 'Hola',
            icon: Icon(
              Icons.business,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Hola',
            icon: Icon(
              Icons.school,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Firestore.instance.collection('usuarios').getDocuments();
    setState(() {
      _numCamas = countDocuments('usuarios');
    });
    return null;
  }
}

Future<int> countDocuments(String colection) async {
  QuerySnapshot _myDoc =
      await Firestore.instance.collection(colection).getDocuments();

  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  return (_myDocCount.length);
}
