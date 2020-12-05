import 'package:flutter/material.dart';

import 'package:smartHospital/linePlot.dart';
import 'package:smartHospital/linePlot.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:smartHospital/values/customColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VitalCard extends StatelessWidget {
  VitalCard({
    @required this.phoneWidth,
    @required this.title,
    @required this.phoneHeight,
    @required this.document,
    @required this.vital,
    @required this.greenDownLimit,
    @required this.greenUpLimit,
    @required this.orangeDownLimit,
    @required this.orangeUpLimit,
    @required this.icon,
    @required this.magnitude,

  });
  final String title;
  final double phoneWidth;
  final double phoneHeight;
  final DocumentSnapshot document;
  final String vital;
  final double greenDownLimit;
  final double greenUpLimit;
  final double orangeDownLimit;
  final double orangeUpLimit;
  final String icon;
  final String magnitude;
  @override
  Widget build(BuildContext context) {
    double green = 36.2;
    return Container(
      child: FocusedMenuHolder(
        menuWidth: phoneWidth,
        onPressed: () {},
        menuItemExtent: (phoneHeight / 100) * 35,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
            title: LinePLot(
              data: document[vital],
            ),
            onPressed: () {},
          )
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
                  child: Row(
                    children: [
                    SizedBox(width: (phoneWidth / 100) * 4),
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Muli',
                          fontSize: 18),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                                          child: Row(
                                            children: [
                                              Text(
                        document[vital][document[vital].length - 1].toString() +
                            ' ' + magnitude,
                        style: TextStyle(
                            color: document[vital][document[vital].length - 1] >=
                                        greenDownLimit &&
                                    document[vital][document[vital].length - 1] <=
                                greenUpLimit        
                                ? CustomColors.goodGreen
                                : document[vital][document[vital].length - 1] >=
                                                orangeDownLimit &&
                                        document[vital]
                                                    [document[vital].length - 1] <=
                                                orangeUpLimit
                                    ? Colors.orange
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli',
                            fontSize: 18),
                      ),
                      SizedBox(width: 20,),
                      Image.asset(icon, width: 30),
                      SizedBox(width: 20,),
                                            ],
                                          ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
