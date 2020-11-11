import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/addUser.dart';
import 'package:smartHospital/addUser.dart';

class homePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => addUserWidget()));
        },
        child: Icon(Icons.add),
      ),
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
            return SizedBox(
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
                        Text(
                          camasOcupadas["ocupadas"].toString() + "/60",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Muli',
                              fontSize: 20.0),
                        ),
                        Text('')
                      ],
                    ),
                  ),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
