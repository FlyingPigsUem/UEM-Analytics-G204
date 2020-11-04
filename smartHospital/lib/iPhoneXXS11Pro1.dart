import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class iPhoneXXS11Pro1 extends StatelessWidget {
  iPhoneXXS11Pro1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(60.0, 80.0),
            child:
                // Adobe XD layer: 'Inkedunnamed_LI' (shape)
                Container(
              width: 256.0,
              height: 95.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.0),
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(158.0, 210.5),
            child:
                // Adobe XD layer: 'Login' (text)
                SizedBox(
              width: 60.0,
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 17,
                  color: const Color(0xff205072),
                  height: 1.3529411764705883,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(85.5, 254.5),
            child:
                // Adobe XD layer: 'Enter your login det' (text)
                SizedBox(
              width: 204.0,
              child: Text(
                'Enter your login details to\naccess your account',
                style: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 13,
                  color: const Color(0xff5192ca),
                  height: 1.5384615384615385,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(49.0, 612.0),
            child:
                // Adobe XD layer: 'Button' (group)
                SizedBox(
              width: 295.0,
              height: 60.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 295.0, 60.0),
                    size: Size(295.0, 60.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Bg' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          begin: Alignment(1.45, 1.0),
                          end: Alignment(-0.8, 2.38),
                          colors: [
                            const Color(0xff0367cc),
                            const Color(0xff339dfa)
                          ],
                          stops: [0.0, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x33000000),
                            offset: Offset(0, 15),
                            blurRadius: 45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(70.0, 20.0, 156.0, 20.0),
                    size: Size(295.0, 60.0),
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'SET TEMPERATURE' (text)
                        Text(
                      'INICIAR SESION',
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        letterSpacing: 2.285714599609375,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(29.0, 348.0),
            child:
                // Adobe XD layer: 'Group 2' (group)
                SizedBox(
              width: 324.0,
              height: 71.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 324.0, 71.0),
                    size: Size(324.0, 71.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Rectangle' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80339dfa),
                            offset: Offset(0, 15),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(54.0, 370.0),
            child: Text(
              'juliamartinezg@riojasalud.com',
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: 15,
                color: const Color(0xff205072),
                height: 1.5333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(),
          Transform.translate(
            offset: Offset(29.0, 450.0),
            child:
                // Adobe XD layer: 'Group 2' (group)
                SizedBox(
              width: 324.0,
              height: 71.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 324.0, 71.0),
                    size: Size(324.0, 71.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Rectangle' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80339dfa),
                            offset: Offset(0, 15),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(81.0, 476.0),
            child: Text(
              'Contraseña',
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: 15,
                color: const Color(0xffd0dae1),
                height: 1.5333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
