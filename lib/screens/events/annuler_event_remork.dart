import 'package:track/data/matricules_remorque.dart';
import 'package:track/data/motifs.dart';
import 'package:track/services/evenement_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnulerRemorkEvent extends StatefulWidget {

  final event;
  AnnulerRemorkEvent({this.event});

  @override
  _AnnulerRemorkEventState createState() => _AnnulerRemorkEventState();
}

class _AnnulerRemorkEventState extends State<AnnulerRemorkEvent> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String dateString;
  String idUser ='';
  String idEvent = '';
  String heureDarriveRemorque;
  String matriculeRemorque;
  String action='';
  String motif;

  Widget load;
  dynamic eventRemorkResponse;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefsGetIdUser();
    idEvent= widget.event['id'];
    action = 'annuler';
    dateTimeString ='';
    dateTimeString1 ='';
    dateString ='';
    heureDarriveRemorque = '';
    motif='';
    matriculeRemorque = '';
    load = null;

  }


  void initPrefsGetIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('idUser') ?? '' ;
  }

  void annulerRemork(BuildContext context) async {
   var response = await EvenementService.annulerRemork(
       idEvent,
       action,
       dateTimeString1,
       heureDarriveRemorque,
       matriculeRemorque,
       idUser,
       motif
   );
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        eventRemorkResponse = response['evenement'];

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Remorquage Annulé  avec succes',
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
      annulerRemork(context);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annuler Remorquage'),

      ),
      body:Builder(builder: (BuildContext context) {
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
                  dateTimeString1 = value.toIso8601String().substring(0, 10);
                  print(dateTimeString);
                  List<String> listDateTime = splitDateTime(dateTimeString);
                  dateString = listDateTime[0];
                  heureDarriveRemorque = listDateTime[1];
                  print(dateString);
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
              child: DropDownFormField(
                filled: true,

                titleText: 'Matricule Remorque',
                hintText: 'Selectionnez votre Remorque',
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

                titleText: 'Motif',
                hintText: 'Selectionnez le motif',
                value: motif,
                onSaved: (value) {
                  setState(() {
                    motif = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    motif = value;
                  });
                },
                dataSource: motifs,
                validator: (value) {
                  if (value == null) {
                    return 'Donnez le motif';
                  }
                  return null;
                },
                textField: 'display',
                valueField: 'value',
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
                    print(dateTimeString1);
                    print(heureDarriveRemorque);
                    print(matriculeRemorque);
                    print(idEvent);
                    print(idUser);
                    print(motif);
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