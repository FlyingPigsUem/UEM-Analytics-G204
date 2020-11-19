import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/addUser.dart';

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
              SizedBox(
                height: phoneHeight / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Card(
                      child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cama.jpg'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment(-0.7, -0.9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                              ),
                              Text(
                                'Camas',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                    fontSize: 30),
                              ),
                            ],
                          ),
                          FutureBuilder(
                              future: _numCamas,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.toString());
                                } else {
                                  return Text('Loading...');
                                }
                              }),
                          Text('')
                        ],
                      ),
                    ),
                  )),
                ),
              ),
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
