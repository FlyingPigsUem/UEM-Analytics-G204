import 'package:flutter/material.dart';
import 'package:smartHospital/customColors.dart';

class HomeCardWidget extends StatelessWidget {
  /// Creates a HomeCard.
  ///
  /// The HomeCards has similar behaviour to a button, on Tapping it will do the [onTap] function.
  ///
  /// The Card is decorated with an [img] and displays the [title].
  ///
  /// [phoneWidth] and [phoneHeight] are used to allow the application to be responsive.
  HomeCardWidget(
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

        //  The InkWell Widget allows the Container to have an onTap function.

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            //  This BoxDecoration displays a shadow around the Card that creates a elevation effect.

            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(50.0),
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
              height: phoneHeight / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    //  The DecorationImage is used to be able to use the colorFilter
                    //  and apply a filter to the image.

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

                    //  Displays the title of the Widget
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
      ),
    );
  }
}
