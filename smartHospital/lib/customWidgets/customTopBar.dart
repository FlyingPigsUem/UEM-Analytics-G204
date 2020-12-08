import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom appBar
  ///
  /// It diaplays the title and the image in a modern way.
  TopBar(
      {@required this.drInfo,
      @required this.onPressed,
      this.onTitleTapped})
      : preferredSize = Size.fromHeight(120.0);

  /// Name displayed on the TopBar
  final Future<dynamic> drInfo;

 
  final Function onPressed;
  final Function onTitleTapped;

  @override

  /// Height of the Widget
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FutureBuilder(
                  future: drInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // The Hero with the topBarBtn corresponds to the image button
                      return Hero(
                        tag: 'topBarBtn',
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(360.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(300.0),
                                child: Image.network(
                                  snapshot.data['imagen'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
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
              FutureBuilder(
                  future: drInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Hero(
                        tag: 'title',
                        transitionOnUserGestures: true,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: InkWell(
                            onTap: onTitleTapped,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    snapshot.data['nombre'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      // color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                  })
              // The Hero with the title tag corresponds to the name displayer
            ],
          ),
        ],
      ),
    );
  }
}
