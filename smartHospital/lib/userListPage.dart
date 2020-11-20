import 'package:flutter/material.dart';
import 'package:smartHospital/customTopBar.dart';
import 'package:smartHospital/colors.dart';

class userListPage extends StatelessWidget {
  userListPage({
    @required this.drName,
    @required this.drImgAsset,
  });
  final String drName;
  final String drImgAsset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: drName,
        img: drImgAsset,
        onPressed: null,
      ),
      body: Container(color: Colors.amber),
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
}
