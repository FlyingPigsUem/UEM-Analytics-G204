import 'package:flutter/material.dart';
import 'package:smartHospital/colors.dart';

class camasCardWidget extends StatefulWidget {
  camasCardWidget(
      {@required this.phoneWidth,
      @required this.phoneHeight,
      @required this.numeroCama});
  final double phoneWidth;
  final double phoneHeight;
  Future<int> numeroCama;
  @override
  _camasCardWidgetState createState() => _camasCardWidgetState();
}

class _camasCardWidgetState extends State<camasCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(50.0),
          boxShadow: [
            new BoxShadow(
                color: colors.shadowBlue.withAlpha(50),
                offset: new Offset(0.0, 10.0),
                blurRadius: 300.0,
                spreadRadius: 0.0)
          ],
        ),
        child: SizedBox(
          height: widget.phoneHeight / 4,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/cama.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstOut),
                  ),
                ),
                child: Align(
                  alignment: Alignment(0.3, -0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 1),
                        child: Column(
                          children: [
                            Text(
                              'Camas',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Muli',
                                  fontSize: 30),
                            ),
                            FutureBuilder(
                                future: widget.numeroCama,
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
