import 'package:flutter/material.dart';
import 'package:smartHospital/formUserPage/addUserPage.dart';
import 'package:smartHospital/homePage/camasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/homePage/patientCardWidget.dart';
import 'package:smartHospital/homePage/patientCardWidget.dart';

import 'package:smartHospital/customWidgets/customTopBar.dart';
import 'package:smartHospital/userListPage/userPage.dart';

class HomePage extends StatefulWidget {
  /// Home page of the app.
  ///
  /// * `drName` is the name of the Dr. that uses the app.
  /// * `drImgAsset` is the image asset directory of the Dr. that uses the app.
  HomePage({@required this.drName, @required this.drImgAsset});

  /// Name of the Dr. that uses the app.
  final String drName;

  /// Image asset directory of the Dr. that uses the app.
  final String drImgAsset;
  @override
  _HomePageState createState() => _HomePageState();
}

/// State of the homePage.
class _HomePageState extends State<HomePage> {
  /// Number of ocupated beds.
  Future<int> _bedNum = countDocuments('usuarios');
  @override
  Widget build(BuildContext context) {
    /// Width of the phone the app is running.
    double phoneWidth = MediaQuery.of(context).size.width;

    /// Height of the phone the app is running.
    double phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: TopBar(
        title: widget.drName,
        img: widget.drImgAsset,
        onPressed: null,
        onTitleTapped: null,
      ),

      //  The RefreshIndicator allows the app to
      //  refresh the data of the homePage.

      body: RefreshIndicator(
        //  On refresh, the app calls the _handleRefresh method.

        onRefresh: _handleRefresh,

        //  The ListView widget contains all the widgets showed on the
        //  HomePage body.

        child: Column(
          children: [
            //  Widget that contains the information related to the number
            //  of beds ocupated.

            BedCardWidget(
                phoneWidth: phoneWidth,
                phoneHeight: phoneHeight,
                bedNum: _bedNum),

            //  The Divider allows the adjacent Widgets to be separated.
            //  A transparent divider its used.

            Divider(
              color: Color.fromRGBO(255, 255, 255, 0.0),
            ),

            //  Widget that behaves as a custom button.

            StreamBuilder(
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
                                  drImgAsset: widget.drImgAsset,
                                  drName: widget.drName,),

                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),

            Divider(
              color: Color.fromRGBO(255, 255, 255, 0.0),
            ),
          ],
        ),
      ),

      //  The FAB will navigate to the addUserPage to add a patient to the DB.
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

      //  bottomNavigationBar that allows the user to move between pages
    
    );
  }

  /// Handles the refresh time.
  ///
  /// Updates the _bedNum to the actual number of beds ocupied.
  Future<Null> _handleRefresh() async {
    //  The refresh awaits until the Documents from the Collection 'usuarios'
    //  are retrieved.

    await Firestore.instance.collection('usuarios').getDocuments();

    //  The _bedNum is updated.

    setState(() {
      _bedNum = countDocuments('usuarios');
    });

    //  Returns null to finish the process.

    return null;
  }
}

/// Returns the Future<int> number of documents nested in the [collection].
Future<int> countDocuments(String collection) async {
  /// QuerySnapshot of the documents nested in the [collection].
  QuerySnapshot _myDoc =
      await Firestore.instance.collection(collection).getDocuments();

  /// List of the documents nested in the [collection].
  List<DocumentSnapshot> _myDocCount = _myDoc.documents;

  // The function returns the Future<int> length of the list.

  return (_myDocCount.length);
}
