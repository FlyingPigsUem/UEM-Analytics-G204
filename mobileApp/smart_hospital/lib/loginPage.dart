import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_hospital/homePage/homePage.dart';
import 'package:smart_hospital/values/customColors.dart';
import 'package:nice_button/nice_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// The [_formKey] makes the app capable of saving and validating every [FormField].
  final GlobalKey<FormState> _formKey = new GlobalKey();

  /// The [_formKey] makes the app capable of displaying [SnackBar]s.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  /// [_autoValidate] as true, will validate the [FormField]s.
  bool _autoValidate = false;

  /// The [_formUser] saves the data of the [FormField]s.
  FormDoctor _formDoctor = FormDoctor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset('assets/images/logo_hospital.png'),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(30.0),
                      boxShadow: [
                        new BoxShadow(
                          color: CustomColors.shadowBlue.withAlpha(70),
                          offset: new Offset(0.0, 10.0),
                          blurRadius: 50.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextFormField(
                        //  If the value is empty return a message, if not return null (continue).

                        validator: (value) {
                          return value.isEmpty ? "No puede estar vacío" : null;
                        },
                        //  The value is saved in the formUser.name.

                        onSaved: (value) {
                          setState(() {
                            _formDoctor.mail = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(30.0),
                      boxShadow: [
                        new BoxShadow(
                          color: CustomColors.shadowBlue.withAlpha(70),
                          offset: new Offset(0.0, 10.0),
                          blurRadius: 50.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextFormField(
                        obscureText: true,
                        //  If the value is empty return a message, if not return null (continue).

                        validator: (value) {
                          return value.isEmpty ? "No puede estar vacío" : null;
                        },
                        //  The value is saved in the formUser.name.

                        onSaved: (value) {
                          setState(() {
                            _formDoctor.psw = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: NiceButton(
                      radius: 40,
                      padding: const EdgeInsets.all(15),
                      text: "Entrar",
                      icon: Icons.account_box,
                      gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                      onPressed: _save,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      checkIfExists(_formDoctor.mail, _formDoctor.psw).then((String doctorID) {
        if (doctorID == null) {
          _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              content: Text("Correo o contraseñas incorrectos"),
              
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(drId: doctorID)),
          );
        }
      });

      // Navigates to the previous Page.

    } else {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Correo o contraseña erroneos"),
        ),
      );
    }
  }
}

class FormDoctor {
  String mail;
  String psw;
}

Future<String> checkIfExists(String email, String password) async {
  final databaseReference = Firestore.instance;
  dynamic document = await databaseReference
      .collection('doctores')
      .where('correo', isEqualTo: email)
      .where('contraseña', isEqualTo: password)
      .getDocuments();

  if (document.documents.isEmpty) {
    return null;
  } else {
    return document.documents[0].documentID;
  }
}
