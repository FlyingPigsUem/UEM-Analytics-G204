import 'package:flutter/material.dart';
import 'package:smartHospital/formUserPage/addUserPage.dart';
import 'package:smartHospital/homePage/camasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/homePage/homeCardWidget.dart';
import 'package:smartHospital/homePage/patientCardWidget.dart';
import 'package:smartHospital/values/customColors.dart';
import 'package:smartHospital/customWidgets/customTopBar.dart';
import 'package:smartHospital/userListPage/userListPage.dart';

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

        child: ListView(
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

            HomeCardWidget(
              phoneWidth: phoneWidth,
              phoneHeight: phoneHeight,
              title: 'Pacientes',
              img: 'assets/images/pacientes.jpg',

              //  On tap the App will navigate to the userListPage.

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => userListPage(
                      drName: widget.drName,
                      drImgAsset: widget.drImgAsset,
                    ),
                  ),
                );
              },
            ),
            Divider(
              color: Color.fromRGBO(255, 255, 255, 0.0),
            ),
            Center(
              child: PatientCard(),
            )
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'Hola',
              icon: Icon(
                Icons.home,
                color: CustomColors.mainBlue,
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
