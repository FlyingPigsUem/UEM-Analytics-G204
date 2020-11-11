import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addUserWidget extends StatefulWidget {
  @override
  _addUserWidgetState createState() => _addUserWidgetState();
}

class _addUserWidgetState extends State<addUserWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  String sexo;
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
      body: ListView(
        children: [
          Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.nombre = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Nombre'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.apellidos = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Apellidos'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      return value == null ? "No puede estar vacio" : null;
                    },
                    onSaved: (val) {
                      setState(() {
                        if (val == 'mujer') {
                          _formUser.mujer == true;
                        } else {
                          _formUser.mujer == false;
                        }
                      });
                    },
                    value: sexo,
                    items: ['hombre', 'mujer'].map<DropdownMenuItem<String>>(
                      (String val) {
                        return DropdownMenuItem(
                          child: Text(val),
                          value: val,
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        sexo = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Sexo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.edad = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Edad'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.altura = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Altura en cm'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      return value.isEmpty ? "No puede estar vacio" : null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.numeroCama = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Numero de cama'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ("No puede estar vacio");
                      }
                      // ignore: unrelated_type_equality_checks
                      if (isNumeric(value) == false) {
                        return ("El formato no es adecuado");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.peso = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Peso'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ("No puede estar vacio");
                      }
                      // ignore: unrelated_type_equality_checks
                      if (isNumeric(value) == false) {
                        return ("El formato no es adecuado");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _formUser.temperatura = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Temperatura'),
                  ),
                ),
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
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Todo bien"),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: Text("Revisa el formulario"),
        ),
      );
    }
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
