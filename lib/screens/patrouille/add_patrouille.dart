import 'package:track/data/itineraire.dart';
import 'package:track/data/matricules.dart';
import 'package:track/data/matricules_pats.dart';
import 'package:track/services/patrouille_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPatrouille extends StatefulWidget {
  final loginResponse;
  AddPatrouille({this.loginResponse});

  @override
  _AddPatrouilleState createState() => _AddPatrouilleState();
}

class _AddPatrouilleState extends State<AddPatrouille> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String dateString;
  String timeString;
  String matriculeVehicule;
  String itineraire;
  int kilometrage;
  String pat1;
  String pat2;
  Widget load;
  dynamic patrouilleResponse;
  String result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.loginResponse['user']['username']);
    dateTimeString = '';
    dateString = '';
    timeString = '';
    matriculeVehicule = '';
    itineraire = '';
    kilometrage = 0;
    pat1 = widget.loginResponse['user']['username'];
    pat2 = '';
    result = '';
    load = null;
  }

  void debuterPatrouille(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var response = await PatrouilleService.debuterPatrouille(
        dateTimeString1,
        matriculeVehicule,
        timeString,
        kilometrage,
        itineraire,
        pat1,
        pat2
    );
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        patrouilleResponse = response['patrouille'];
        prefs.setString('idPatrouille', patrouilleResponse['id']);
        print(' id patrouille '+prefs.getString('idPatrouille') ?? '') ;

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Patrouille demarrée avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(patrouilleResponse);
      });
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Operation Echouée !!!',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.red,
      ));

    }
  }

  void loading() {
    setState(() {
      load = loadingUI();
    });
  }

  Widget loadingUI() {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: CircularProgressIndicator(),
      ),
    ));
  }


  saveForm(BuildContext context) {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'En cours de traitement',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.pinkAccent,
      ));
      loading();
      debuterPatrouille(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Démarrer Patrouille'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeField(
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Date et Heure début patrouille',
                      labelText: 'Date et Heure',
                      prefixIcon: Icon(
                        Icons.date_range
                      )
                    ),
                    onChanged: (value) {
                      dateTimeString = format.format(value);
                      dateTimeString1 = value.toIso8601String().substring(0, 10);
                      print(dateTimeString);
                      List<String> listDateTime = splitDateTime(dateTimeString);
                      dateString = listDateTime[0];
                      timeString = listDateTime[1];
                      print(dateString);
                      print(timeString);
                    },
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez la Date et l\'heure';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    filled: true,

                    titleText: 'Matricule Vehicule',
                    hintText: 'selectionnez votre Vehicule',
                    value: matriculeVehicule,
                    onSaved: (value) {
                      setState(() {
                        matriculeVehicule = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        matriculeVehicule = value;
                      });
                    },
                    dataSource: matricules,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez le Matricule Vehicule';
                      }
                      return null;
                    },
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Début Kilometrage',
                      labelText: 'Kilometrage',
                      filled: true,
                      prefixIcon: Icon(
                        Icons.slow_motion_video
                      )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      kilometrage = int.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Entrez le kilometrage';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(

                    filled: true,
                    titleText: 'Itineraire',
                    hintText: 'selectionnez votre itinéraire',
                    value: itineraire,
                    onSaved: (value) {
                      setState(() {
                        itineraire = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        itineraire = value;
                      });
                    },
                    dataSource: itineraires,
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez votre itineraire';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    filled: true,
                    titleText: 'Patrouilleur 2',
                    hintText: 'selectionnez votre coequipier',
                    value: pat2,
                    onSaved: (value) {
                      setState(() {
                        pat2 = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        pat2 = value;
                      });
                    },
                    dataSource: pats,
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez votre coequipier';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // icon:Icon(Icons.person),
                      hintText: 'Patrouilleur 1',
                      labelText: 'Patrouilleur 1',
                      prefixIcon: Icon(
                        Icons.account_box
                      )
                    ),
                    initialValue: pat1,
                    readOnly: true,
                  ),
                ),

                Center(
                  child: Container(
                    child: load,
                  ),
                ),
                Container(

                    padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0),
                    child: RaisedButton(
                      color: Color(0xFF100D60),
                      child: Text(
                        'Valider',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        print("send");
                        print(dateString);
                        print(timeString);
                        print(dateTimeString);
                        print(kilometrage);
                        print(matriculeVehicule);
                        print(pat1);
                        print(pat2);
                        saveForm(context);
                      },
                    )
                ),
              ],
            ),
          );
        }));
  }
}

List<String> splitDateTime(String dateTimeString) {
  List<String> dateTimeList = dateTimeString.split(' ');
  return dateTimeList;
}
