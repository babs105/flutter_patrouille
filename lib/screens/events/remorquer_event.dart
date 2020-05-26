import 'package:track/data/gares.dart';
import 'package:track/data/matricules_remorque.dart';
import 'package:track/data/sorties.dart';
import 'package:track/services/evenement_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemorquerEvent extends StatefulWidget {
  final event;

  RemorquerEvent({this.event});


  @override
  _RemorquerEventState createState() => _RemorquerEventState();
}

class _RemorquerEventState extends State<RemorquerEvent> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  final format1 = DateFormat("dd/MM/yyyy");
  final formatTime = DateFormat("HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String dateString;
  String idUser ='';
  String idEvent = '';
  String heureDarriveRemorque;
  String heureRemorquage;
  String matriculeRemorque;
  String  dt;
  String  dateTimeStr;
  String lieuDepot='';
  String nomDepot='';
  String gareDepot='';
  Widget load;
  dynamic eventRemorkResponse;



 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefsGetIdUser();
    idEvent= widget.event['id'];
    lieuDepot ='GARE';
    dateTimeString ='';
    dateTimeString1 ='';
    dateString ='';
    heureDarriveRemorque ='';
    heureRemorquage ='';
    matriculeRemorque = '';
    lieuDepot ='';
    nomDepot ='';
    gareDepot ='';
    load = null;

 }


void initPrefsGetIdUser() async {
  final prefs = await SharedPreferences.getInstance();
  idUser = prefs.getString('idUser') ?? '' ;
}

void remorker(BuildContext context) async {
  var response = await EvenementService.remorker(
      idEvent,
      dateTimeString1,
      idUser,
      heureRemorquage,
      heureDarriveRemorque,
      matriculeRemorque,
      gareDepot=lieuDepot+" "+nomDepot,
  );
  print(response);

  if (response['error'] == false) {
    setState(() {
      load = null;
      eventRemorkResponse = response['evenement'];

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Remorquage effectué  avec succes',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.green,
      ));
      print(eventRemorkResponse);
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
   remorker(context);

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Remorquer')
      ),
      body: Builder(builder: (BuildContext context) {
        return Form(
          key:_formKey,
          autovalidate: false,
          child:ListView(
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
                      hintText: 'Date et Heure d\'arrivee ',
                      labelText: 'Date et Heure d\'arrivee' ,
                      prefixIcon: Icon(
                          Icons.date_range
                      )
                  ),
                  onChanged: (value) {
                    dateTimeString = format.format(value);
                    dateTimeStr = value.toIso8601String();
                    dateTimeString1 = value.toIso8601String().substring(0,10);
                    dt=dateTimeString.substring(0,10);
                    List<String> listDateTime = splitDateTime(dateTimeString);
                    dateString = listDateTime[0];
                    heureDarriveRemorque = listDateTime[1];
                    print(dt);
                    print(dateTimeString);
                    print(dateTimeStr);
                    print(dateTimeString1);
                    print(heureDarriveRemorque);
                  },
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez la Date et l\'heure d\'arrivée';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:DateTimeField(
                  format: formatTime,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },

                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Heure remorquée',
                      labelText: 'Heure remorquée',
                      prefixIcon: Icon(Icons.timer)
                  ),
                  onChanged: (value) {
                    heureRemorquage = formatTime.format(value);
                  //  dateTimeString1 = value.toIso8601String().substring(0,10);


                    print(heureRemorquage);
                  },
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure remorquée';
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
                  value: matriculeRemorque,
                  onSaved: (value) {
                    setState(() {
                      matriculeRemorque = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      matriculeRemorque = value;
                    });
                  },
                  dataSource: matriculesRemorque,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez le Matricule Remorque';
                    }
                    return null;
                  },
                  textField: 'display',
                  valueField: 'value',
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(

                  filled: true,
                  titleText: 'Lieu de Dépot',
                  hintText: 'selectionnez votre lieu de dépot',
                  value: lieuDepot,
                  onSaved: (value) {
                    setState(() {
                      lieuDepot = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      lieuDepot = value;
                    });
                  },
                  dataSource: [
                    {'display':'GARE',
                      'value':'GARE'
                    },
                    {'display':'SORTIE',
                      'value':'SORTIE'
                    }
                  ],
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le Lieu de Dépot';
                    }
                    return null;
                  },
                ),
              ),

              lieuDepot == 'GARE'?
               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    filled: true,
                    titleText: 'GARE',
                    hintText: 'selectionnez GARE',
                    value: nomDepot,
                    onSaved: (value) {
                      setState(() {
                        nomDepot = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        nomDepot = value;
                      });
                    },
                    dataSource: gares,
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrez votre la gare de dépot';
                      }
                      return null;
                    },
                  ),
                )
              :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'SORTIE',
                  hintText: 'selectionnez SORTIE',
                  value: nomDepot,
                  onSaved: (value) {
                    setState(() {
                      nomDepot = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      nomDepot = value;
                    });
                  },
                  dataSource: sorties,
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez votre la gare de dépot';
                    }
                    return null;
                  },
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
                      /*print("send");
                      print(dateTimeString1);
                      print(heureRemorquage);
                      print(heureDarriveRemorque);
                      gareDepot=lieuDepot+" "+nomDepot;
                      print(gareDepot);
                      print(matriculeRemorque);
                      print(idEvent);
                      print(idUser);*/
                      saveForm(context);
                    },
                  )
              ),
            ],
          ),
        );
      }) ,
    );

  }
}
List<String> splitDateTime(String dateTimeString) {
  List<String> dateTimeList = dateTimeString.split(' ');
  return dateTimeList;
}