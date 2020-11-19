import 'package:flutter/material.dart';

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
    return SizedBox(
      height: widget.phoneHeight / 4,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cama.jpg'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Align(
              alignment: Alignment(-0.7, -0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                      ),
                      Text(
                        'Camas',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli',
                            fontSize: 30),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: widget.numeroCama,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else {
                          return Text('Loading...');
                        }
                      }),
                  Text('')
                ],
              ),
            ),
          )),
    );
  }
}
