import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_hospital/homePage/homePage.dart';

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
      body: Column(
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
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    //  If the value is empty return a message, if not return null (continue).

                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    //  The value is saved in the formUser.name.

                    onSaved: (value) {
                      setState(() {
                        _formDoctor.mail = value;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    //  If the value is empty return a message, if not return null (continue).

                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    //  The value is saved in the formUser.name.

                    onSaved: (value) {
                      setState(() {
                        _formDoctor.psw = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Contraseña'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _save,
                    child: Text('Entrar'),
                  ),
                )
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
              content: Text("Este doctor no existe"),
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
