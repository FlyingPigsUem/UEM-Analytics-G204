import 'package:flutter/material.dart';

class homeCardWidget extends StatelessWidget {
  homeCardWidget(
      {@required this.phoneWidth,
      @required this.phoneHeight,
      @required this.title,
      @required this.img});
  final double phoneWidth;
  final double phoneHeight;
  final String title;
  final String img;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: phoneHeight / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}
