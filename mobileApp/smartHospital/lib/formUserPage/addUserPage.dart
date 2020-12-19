import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartHospital/formUserPage/userFormWidget.dart';

/// Page that allow the user to complete a form and send patient data to the firestore database.
class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

/// State of the AddUserPage
class _AddUserPageState extends State<AddUserPage> {
  /// The [_formKey] makes the app capable of saving and validating every [FormField].
  final GlobalKey<FormState> _formKey = new GlobalKey();

  /// The [_formKey] makes the app capable of displaying [SnackBar]s.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  /// [_autoValidate] as true, will validate the [FormField]s.
  bool _autoValidate = false;

  /// The [_formUser] saves the data of the [FormField]s.
  FormUser _formUser = FormUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // By pressing the FAB the app will run the _save method.

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _save,
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Añadir usuario'),
      ),

      //  The body returns the userFormWidget.

      body: UserFormWidget(
          formKey: _formKey, autoValidate: _autoValidate, formUser: _formUser),
    );
  }

  /// Saves the information stored in the [FormField]s.
  ///
  /// In case all the information is fine, it will create a documend, send it to Firestore
  /// and return to de HomePage.
  ///
  /// If not, it will suggest the user to review the form.
  void _save() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      createRecord(
        'usuarios',
          _formUser.name,
          _formUser.surName,
          _formUser.age,
          _formUser.height,
          _formUser.isWoman,
          _formUser.bedNum,
          _formUser.weight,
          _formUser.temperature);
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Datos guardados"),
        ),
      );

      // Navigates to the previous Page.

      Navigator.pop(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Revisa el formulario"),
        ),
      );
    }
  }
}

/// User Object
class FormUser {
  String name;
  String surName;
  int age;
  int height;
  bool isWoman;
  int bedNum;
  double weight;
  double temperature;
}

/// Returns if a String is a number
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

/// Creates a document in the [collection]
void createRecord(String collection,String name, String surName, int age, int height,
    bool isWoman, int bedNum, double weight, double temperature) async {
  final databaseReference = Firestore.instance;
  await databaseReference.collection(collection).document().setData({
    'height': height,
    'surName': surName,
    'age': age,
    'isWoman': isWoman,
    'name': name,
    'bedNum': bedNum,
    'weight': FieldValue.arrayUnion([weight]),
    'temperature': FieldValue.arrayUnion([temperature])
  });
}
