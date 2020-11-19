import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/userFormWidget.dart';

class addUserPage extends StatefulWidget {
  @override
  _addUserPageState createState() => _addUserPageState();
}

class _addUserPageState extends State<addUserPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _autoValidate = false;
  FormUser _formUser = FormUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _save,
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Añadir usuario'),
      ),
      body: userFormWidget(
          formKey: _formKey, autoValidate: _autoValidate, formUser: _formUser),
    );
  }

  void _save() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      createRecord(
          _formUser.nombre,
          _formUser.apellidos,
          _formUser.edad,
          _formUser.altura,
          _formUser.mujer,
          _formUser.numeroCama,
          _formUser.peso,
          _formUser.temperatura);
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Datos guardados"),
        ),
      );
      Navigator.pop(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Revisa el formulario"),
        ),
      );
    }

    Navigator.pop(context);
  }
}

class FormUser {
  String nombre;
  String apellidos;
  int edad;
  int altura;
  bool mujer;
  int numeroCama;
  double peso;
  double temperatura;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

void createRecord(String nombre, String apellidos, int edad, int altura,
    bool mujer, int numeroCama, double peso, double temperatura) async {
  final databaseReference = Firestore.instance;
  await databaseReference.collection("usuarios").document().setData({
    'altura': altura,
    'apellidos': apellidos,
    'edad': edad,
    'mujer': mujer,
    'nombre': nombre,
    'numeroCama': numeroCama,
    'peso': peso,
    'temperatura': temperatura
  });
}
