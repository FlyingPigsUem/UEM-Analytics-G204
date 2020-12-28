import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_hospital/homePage/patientCardWidget.dart';

import 'package:smart_hospital/customWidgets/customTopBar.dart';
import 'package:smart_hospital/userListPage/userPage.dart';

class AllPatientsPage extends StatefulWidget {
  /// Home page of the app.
  ///
  /// * `drId` is the image asset directory of the Dr. that uses the app.
  AllPatientsPage({@required this.drInfo});

  /// Id of the Dr. that uses the app.
  final Future<dynamic> drInfo;

  @override
  _AllPatientsPageState createState() => _AllPatientsPageState();
}

/// State of the homePage.
class _AllPatientsPageState extends State<AllPatientsPage> {
  /// Number of ocupated beds.

  @override
  Widget build(BuildContext context) {
    /// Width of the phone the app is running.
    double phoneWidth = MediaQuery.of(context).size.width;

    /// Height of the phone the app is running.
    double phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(
        drInfo: widget.drInfo,
        onPressed: null,
        onTitleTapped: null,
      ),
      body: Column(children:[
StreamBuilder(
          stream: Firestore.instance.collection('usuarios').orderBy("Alerta",descending: true).snapshots(),
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
                      document: snapshot.data.documents[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              phoneWidth: phoneWidth,
                              phoneHeight: phoneHeight,
                              document: snapshot.data.documents[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          }),
      ])
      
    );
  }
}

/* 
    return Scaffold(
      appBar: TopBar(
        drInfo: widget.drInfo,
        onPressed: null,
        onTitleTapped: null,
      ),

      //  The RefreshIndicator allows the app to
      //  refresh the data of the homePage.

      body: StreamBuilder(
        stream: Firestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Text('Loading...',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli',
                    fontSize: 24));
          return Expanded(
            child: SizedBox(
              height: phoneHeight,
              child: ListView.builder(
                itemExtent: 120,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => PatientCard(
                  phoneHeight: phoneHeight,
                  phoneWidth: phoneWidth,
                  document: snapshot.data.documents[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage(
                            phoneWidth: phoneWidth,
                            phoneHeight: phoneHeight,
                            document: snapshot.data.documents[index],
                            ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      )

      //  The FAB will navigate to the addUserPage to add a patient to the DB.

      //  bottomNavigationBar that allows the user to move between pages

  
      
    );
  }
}
 */
