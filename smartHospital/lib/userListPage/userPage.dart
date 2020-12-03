import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:smartHospital/customWidgets/customTopBar.dart';
import 'package:smartHospital/linePlot.dart';
import 'package:smartHospital/values/customColors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatelessWidget {
  UserPage({
    @required this.drName,
    @required this.drImgAsset,
    @required this.phoneWidth,
    @required this.phoneHeight,
    @required this.document,
  });
  final String drName;
  final String drImgAsset;
  final double phoneWidth;
  final double phoneHeight;
  final DocumentSnapshot document;
  final auxArr=[4,2,6,2,6,5,7];
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: drName,
        img: drImgAsset,
        onPressed: null,
      ),
      body: ListView(
        children: [
          Text(document['name']),
          Container(
            
            child: FocusedMenuHolder(
              
              menuWidth: phoneWidth,
              onPressed: (){},
              menuItemExtent: (phoneHeight/100)*35,
              menuItems: <FocusedMenuItem>[
                FocusedMenuItem(title: LinePLot(data: [4,2,5,2,56,6,3,5],),onPressed: (){},)
              ],
                          child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => {},
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
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
                      height: phoneHeight / 16,
                      width: phoneWidth,
                      child: Expanded(
                        child: Row(children: [
                          SizedBox(width: (phoneWidth / 100) * 4),
                          Text(
                            'Temperatura',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Muli',
                                fontSize: 18),
                          ),
                          Spacer(
                            flex: 10,
                          ),
                          Text(
                            document['temperature']
                                    [document['temperature'].length - 1]
                                .toString()+'ºC',
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
                          Spacer(flex: 2,),
                          Image.asset('assets/images/Icons- fever.png'),
                          Spacer()
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
}
