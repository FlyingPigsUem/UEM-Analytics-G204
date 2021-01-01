import 'package:flutter/material.dart';
import 'package:smart_hospital_web/values/customColors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientCard extends StatelessWidget {
  /// Creates a HomeCard.
  ///
  /// The HomeCards has similar behaviour to a button, on Tapping it will do the [onTap] function.
  ///
  /// The Card is decorated with an [img] and displays the [title].
  ///
  /// [phoneWidth] and [phoneHeight] are used to allow the application to be responsive.
  PatientCard({
    @required this.phoneWidth,
    @required this.phoneHeight,
    @required this.document,
  });
  final double phoneWidth;
  final double phoneHeight;
  final DocumentSnapshot document;
  @override
  Widget build(BuildContext context) {
    var decorationImage;
    try {
      decorationImage = DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
            document['img'],
          ));
    } catch (Exception) {
      decorationImage = DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/paciente.png'),
      );
    }

    return document['Pulso'] != null
        ? Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),

              //  The InkWell Widget allows the Container to have an onTap function.

              child: InkWell(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  //  This BoxDecoration displays a shadow around the Card that creates a elevation effect.

                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(30.0),
                    boxShadow: [
                      new BoxShadow(
                        color: CustomColors.shadowBlue.withAlpha(50),
                        offset: new Offset(0.0, 10.0),
                        blurRadius: 300.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 300,
                    width: phoneWidth,
                    child: Row(
                      children: [
                        SizedBox(width: (phoneWidth / 100) * 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: (phoneHeight / 100) * 30,
                              height: (phoneHeight / 100) * 30,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: decorationImage,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: (phoneWidth / 100) * 5),
                        Expanded(
                          child: Column(children: [
                            SizedBox(
                              height: (phoneHeight / 100) * 1,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                          fontSize: 24),
                                    ),
                                    Text(
                                      document['surName'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                Spacer(flex: 6),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: (phoneHeight / 100) * 8,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 20.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                          color: document['Alerta'] == 0
                                              ? CustomColors.goodGreen
                                              : document['Alerta'] == 1
                                                  ? Colors.orange
                                                  : Colors.red,
                                          shape: BoxShape.circle),
                                    ),
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      child: new RawMaterialButton(
                                        shape: new CircleBorder(),
                                        elevation: 0.0,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Borrar"),
                                                  content: Text(
                                                      "¿Desea borrar el usuario: " +
                                                          document['name'] +
                                                          " " +
                                                          document["surName"] +
                                                          "?"),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("No"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                        child: Text("Si"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();;
                                                          //ignore: deprecated_member_use
                                                          Firestore.instance
                                                              .collection(
                                                                  'usuarios')
                                                              .doc(document.id)
                                                              .delete();
                                                        }),
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: (phoneHeight / 100) * 10),
                              ],
                            ),
                            Spacer(),
                            Row(children: [
                              Text(
                                document['temperature']
                                            [document['temperature'].length - 1]
                                        .toString() +
                                    'ºC',
                                style: TextStyle(
                                    color: document['temperature'][
                                                    document['temperature'].length -
                                                        1] >=
                                                36.2 &&
                                            document['temperature'][
                                                    document['temperature'].length -
                                                        1] <=
                                                37.2
                                        ? CustomColors.goodGreen
                                        : document['temperature'][
                                                        document['temperature']
                                                                .length -
                                                            1] >=
                                                    35.2 &&
                                                document['temperature']
                                                        [document['temperature'].length - 1] <=
                                                    38.2
                                            ? Colors.orange
                                            : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                    fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                'Cama ' + document['bedNum'].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                    fontSize: 18),
                              ),
                              Spacer(),
                            ]),
                            Spacer(),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
