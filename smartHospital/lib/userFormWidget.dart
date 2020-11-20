import 'package:flutter/material.dart';
import 'package:smartHospital/addUser.dart';

import 'package:flutter/services.dart';

class userFormWidget extends StatefulWidget {
  userFormWidget(
      {@required this.formKey,
      @required this.autoValidate,
      @required this.formUser});
  final formKey;
  final autoValidate;
  final formUser;

  String sexo;

  @override
  _userFormWidgetState createState() => _userFormWidgetState();
}

class _userFormWidgetState extends State<userFormWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: widget.formKey,
          // ignore: deprecated_member_use
          autovalidate: widget.autoValidate,
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
                      widget.formUser.nombre = value;
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
                      widget.formUser.apellidos = value;
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
                    print(val);
                    setState(() {
                      if (val == 'mujer') {
                        widget.formUser.mujer = true;
                      } else {
                        widget.formUser.mujer = false;
                      }
                    });
                  },
                  value: widget.sexo,
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
                      widget.sexo = val;
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
                      widget.formUser.edad = int.parse(value);
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
                      widget.formUser.altura = int.parse(value);
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
                      widget.formUser.bedNum = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Numero de cama'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("No puede estar vacio");
                    }
                    // ignore: unrelatedtypeequalitychecks
                    if (isNumeric(value) == false) {
                      return ("El formato no es adecuado");
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      widget.formUser.peso = double.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Peso'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("No puede estar vacio");
                    }
                    // ignore: unrelatedtypeequalitychecks
                    if (isNumeric(value) == false) {
                      return ("El formato no es adecuado");
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      widget.formUser.temperatura = double.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Temperatura'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
