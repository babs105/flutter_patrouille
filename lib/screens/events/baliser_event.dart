
import 'package:track/data/categories.dart';
import 'package:track/data/natures.dart';
import 'package:track/data/todos.dart';

import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BaliserEvent extends StatefulWidget {
  final dynamic event;

  BaliserEvent({this.event});


  @override
  _BaliserEventState createState() => _BaliserEventState();
}



class _BaliserEventState extends State<BaliserEvent> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("HH:mm");
  String idEvent='';
  String idPatrouille ='';
  String matVehicule='';
  String categorie='';
  String todo ='';
  String dateTimeString1='';
  String timeString='';
  String naturePanne = '';
  dynamic eventToBaliserResponse;
  Widget load;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefsGetIdPatAndEvent();
    load = null;
  }

  void initPrefsGetIdPatAndEvent() async {
    final prefs = await SharedPreferences.getInstance();
  idPatrouille = prefs.getString('idPatrouille') ?? '' ;
  idEvent=widget.event['id'];
  print('id event '+idEvent);
  print('id PAt '+idPatrouille);

  }


  void baliserEvent(BuildContext context) async{

   var response = await EvenementService.baliserEvent(idEvent, idPatrouille, timeString, todo,naturePanne ,categorie, matVehicule);


   if (response['error'] == false) {
     setState(() {
       load = null;
       eventToBaliserResponse = response['evenement'];

       Scaffold.of(context).showSnackBar(SnackBar(
         content: Text(
           'Evenement balise avec succes',
           style: TextStyle(fontSize: 18.0),
         ),
         backgroundColor: Colors.green,
       ));
       print(eventToBaliserResponse);
      // startTime();

      /* Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) {
           return EventScreen(baliser:true);
         }),
       );*/
     });
   }

   else{
     setState(() {
       load = null;
     });
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
      baliserEvent(context);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Balisage'),),
      body: Builder(builder: (BuildContext context) {
        return Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:DateTimeField(
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },

                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Heure balisage',
                    labelText: 'Heure balisage',
                    prefixIcon: Icon(Icons.date_range)
                  ),
                  onChanged: (value) {
                    timeString = format.format(value);
                    dateTimeString1 = value.toIso8601String().substring(0,10);
                    print(timeString);
                  },
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure balisage';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Matricule Vehicule',
                    labelText: 'Matricule',
                    filled: true,
                    prefixIcon: Icon(Icons.slow_motion_video),
                  ),


                  onChanged: (value) {
                    matVehicule = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Entrez la matricule';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'Categorie',
                  hintText: 'selectionnez la catégorie',
                  value: categorie,
                  onSaved: (value) {
                    setState(() {
                      categorie = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      categorie = value;
                    });
                  },
                  dataSource: categories,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez la catagorie';
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
                  titleText: 'Nature Panne',
                  hintText: 'Selectionnez Nature de la Panne',
                  value: naturePanne,
                  onSaved: (value) {
                    setState(() {
                      naturePanne = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      naturePanne = value;
                    });
                  },
                  dataSource: natures,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez la Nature de la Panne';
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
                  titleText: 'Actions à faire',
                  hintText: 'Action',
                  value: todo,
                  onSaved: (value) {
                    setState(() {
                      todo = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      todo = value;
                    });
                  },
                  dataSource: todos,
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez l \'action à faire';
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
                      print("send");
                      print(idEvent);
                      print(idPatrouille);
                      print(timeString);
                      print(categorie);
                      print(matVehicule);
                      print(todo);
                      saveForm(context);
                    /*  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return EventScreen(loginResponse: loginResponse,);
                        }),
                      );*/
                    //  saveForm(context);
                    },
                  )
              ),
            ],
          ),
        );
      }),
    );
  }
}


