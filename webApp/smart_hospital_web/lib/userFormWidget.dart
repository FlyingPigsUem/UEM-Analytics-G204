import 'package:flutter/material.dart';
import 'package:smart_hospital_web/addUserPage.dart';

import 'package:flutter/services.dart';

class UserFormWidget extends StatefulWidget {
  /// This widgets contains all the [FormField]s used in the app to create a patient.
  UserFormWidget(
      {@required this.formKey,
      @required this.autoValidate,
      @required this.formUser});

  /// The [_formKey] makes the app capable of displaying [SnackBar]s.
  final formKey;

  ///[AutoValidate] as true, will validate the [FormField]s.
  final autoValidate;

  /// The [_formUser] saves the data of the [FormField]s.
  final formUser;

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  ///Sex of the patient.
  String sex;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // This form contains a series of FormFields nested in paddings.

        Form(
          key: widget.formKey,
          // ignore: deprecated_member_use
          autovalidate: widget.autoValidate,
          child: Column(
            children: [
              //  1--> Name.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  //  If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value.isEmpty ? "No puede estar vacio" : null;
                  },
                  //  The value is saved in the formUser.name.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.name = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
              ),

              //  2--> Surname.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  //If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value.isEmpty ? "No puede estar vacio" : null;
                  },
                  //  The value is saved in the formUser.surName.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.surName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Apellidos'),
                ),
              ),

              //  3-->Sex, this FormField iss diferent because is a dropdown Menu.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  //If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value == null ? "No puede estar vacio" : null;
                  },
                  onSaved: (val) {
                    print(val);

                    //  The value is saved in the formUser.IsWoman.
                    //  If 'mujer' is selected isWoman = true, else false.

                    setState(() {
                      if (val == 'mujer') {
                        widget.formUser.isWoman = true;
                      } else {
                        widget.formUser.isWoman = false;
                      }
                    });
                  },
                  value: sex,
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
                      sex = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Sexo',
                  ),
                ),
              ),

              //  4--> Age.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],

                  //If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value.isEmpty ? "No puede estar vacio" : null;
                  },

                  //  The value is saved in the formUser.age.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.age = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Edad'),
                ),
              ),

              //  5--> Height.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],

                  //If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value.isEmpty ? "No puede estar vacio" : null;
                  },
                  //  The value is saved in the formUser.height.
                  onSaved: (value) {
                    setState(() {
                      widget.formUser.height = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Altura en cm'),
                ),
              ),

              //  6--> Bed number.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],

                  //If the value is empty return a message, if not return null (continue).

                  validator: (value) {
                    return value.isEmpty ? "No puede estar vacio" : null;
                  },
                  //  The value is saved in the formUser.bedNum.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.bedNum = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Numero de cama'),
                ),
              ),

              //  7--> Weight.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    //if the value is empty or not numeric return a message,
                    //if not return null (continue).

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

                  //  The value is saved in the formUser.weight.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.weight = double.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Peso'),
                ),
              ),

              //  8-->Temperature.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    //if the value is empty or not numeric return a message,
                    //if not return null (continue).

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

                  //  The value is saved in the formUser.temperature.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.temperature = double.parse(value);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Temperatura'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  
                  

                  //  The value is saved in the formUser.temperature.

                  onSaved: (value) {
                    setState(() {
                      widget.formUser.img = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Url de la imagen'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
