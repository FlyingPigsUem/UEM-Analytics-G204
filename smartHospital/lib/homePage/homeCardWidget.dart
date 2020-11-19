import 'package:flutter/material.dart';

class homeCardWidget extends StatelessWidget {
  homeCardWidget(
      {@required this.phoneWidth,
      @required this.phoneHeight,
      @required this.title,
      @required this.img,
      @required this.onTap});
  final double phoneWidth;
  final double phoneHeight;
  final String title;
  final String img;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: phoneHeight / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(50.0),
                              child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstOut),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment(-0.9, 0.7),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Muli',
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
