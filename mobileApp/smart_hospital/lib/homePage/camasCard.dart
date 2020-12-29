import 'package:flutter/material.dart';
import 'package:smart_hospital/values/customColors.dart';

class BedCardWidget extends StatelessWidget {
  /// Creates a Card like Widget.
  ///
  /// This card displays the [bedNum], allowing the user to know how many beds are ocupated.
  ///
  /// [phoneWidth] and [phoneHeight] are used to allow the application to be responsive.
  BedCardWidget(
      {@required this.phoneWidth,
      @required this.phoneHeight,
      @required this.bedNum});

  final double phoneWidth;
  final double phoneHeight;
  final Future<int> bedNum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                spreadRadius: 0.0)
          ],
        ),

        child: SizedBox(
          height: 61,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  //  The DecorationImage is used to be able to use the colorFilter
                  //  and apply a filter to the image.

                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/cama.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.centerRight,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstOut),
                  ),
                ),

                //  Beggins the content of the card.

                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 1),
                        child: Row(
                          children: [
                            //  1-> A Text ('Camas').
                            Text(
                              'Camas',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Muli',
                                  fontSize: 30),
                            ),
                            Spacer(),
                            //  2-> A future builder.
                            //  The future builder displays the bedNumber if the data is retrieved,
                            //  if not, it displays 'Loading...'.
                            FutureBuilder(
                                future: bedNum,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString() + '/60',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                          fontSize: 30),
                                    );
                                  } else {
                                    return Text(
                                      'Loading...',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                          fontSize: 30),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                      //  Used as a line break.
                      Text('')
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
