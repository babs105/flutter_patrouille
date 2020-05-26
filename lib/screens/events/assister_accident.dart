import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:track/services/evenement_service.dart';

class AssisterAccident extends StatefulWidget {
  final event;
  AssisterAccident({this.event});

  @override
  _AssisterAccidentState createState() => _AssisterAccidentState();
}

class _AssisterAccidentState extends State<AssisterAccident> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("HH:mm");
  String idEvent ='';
  int  nbrVehiculeImp = 0;
  int  nbrVoieImp = 0;
  int  nbrBlesse = 0;
  int nbrMort = 0;
  String heureArriveGen ;
  String heureDepGen ;
  String heureArriveSap ;
  String heureDepSap ;
  dynamic accidentToAssistResponse;
  Widget load;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefsGetIdEvent();
    load = null;
  }

  void initPrefsGetIdEvent() {
    idEvent=widget.event['id'];
    print('id event '+idEvent);
    nbrMort = 0;
    nbrBlesse = 0;
    nbrVehiculeImp = 1;
    nbrVoieImp = 1;

  }


  void assisterAccident(BuildContext context) async{

    var response = await EvenementService.assisterAccident(
        idEvent,
        heureArriveGen,
        heureDepGen,
        heureDepSap,
        heureArriveSap,
        nbrVoieImp,
        nbrBlesse,
        nbrMort,
        nbrVehiculeImp
    );


    if (response['error'] == false) {
      setState(() {
        load = null;
        accidentToAssistResponse = response['evenement'];

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Accident assisté  avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(accidentToAssistResponse);
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
          'Traitement En Cours ',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.pinkAccent,
      ));
        loading();
        assisterAccident(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assistance Accident'),
      ),
      body:Builder(builder: (BuildContext context) {
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
                      hintText: 'Heure Arrivée Gendarmes',
                      labelText: 'Heure Arrivée Gendarmes',
                      prefixIcon: Icon(Icons.access_time)
                  ),
                  onChanged: (value) {
                    heureArriveGen = format.format(value);
                  //  dateTimeString1 = value.toIso8601String().substring(0, 10);
                    print(heureArriveGen);
                  },
                  keyboardType: TextInputType.datetime,
                 /* validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure balisage';
                    }
                    return null;
                  },*/
                ),
              ),
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
                      hintText: 'Heure Départ Gendarmes',
                      labelText: 'Heure Départ Gendarmes',
                      prefixIcon: Icon(Icons.access_time)
                  ),
                  onChanged: (value) {
                    heureDepGen = format.format(value);
                    //  dateTimeString1 = value.toIso8601String().substring(0, 10);
                    print(heureDepGen);
                  },
                  keyboardType: TextInputType.datetime,
                  /* validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure balisage';
                    }
                    return null;
                  },*/
                ),
              ),
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
                      hintText: 'Heure Arrivée Sapeurs',
                      labelText: 'Heure Arrivée Sapeurs ',
                      prefixIcon: Icon(Icons.access_time)
                  ),
                  onChanged: (value) {
                    heureArriveSap = format.format(value);
                    //  dateTimeString1 = value.toIso8601String().substring(0, 10);
                    print(heureArriveSap);
                  },
                  keyboardType: TextInputType.datetime,
                  /* validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure balisage';
                    }
                    return null;
                  },*/
                ),
              ),
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
                      hintText: 'Heure Départ Sapeurs',
                      labelText: 'Heure Départ Sapeurs',
                      prefixIcon: Icon(Icons.access_time)
                  ),
                  onChanged: (value) {
                    heureDepSap = format.format(value);
                    //  dateTimeString1 = value.toIso8601String().substring(0, 10);
                    print(heureDepSap);
                  },
                  keyboardType: TextInputType.datetime,
                  /* validator: (value) {
                    if (value == null) {
                      return 'Entrez l\'heure balisage';
                    }
                    return null;
                  },*/
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nombre Véhicule impliqué',
                    labelText: 'Nombre Véhicule impliqué',
                    filled: true,
                    prefixIcon: Icon(Icons.local_car_wash),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    nbrVehiculeImp = int.parse(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Donner le nombre véhicule impliqué';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nombre de Morts',
                    labelText: 'Nombre de Morts',
                    filled: true,
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    nbrMort = int.parse(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Donner le nombre de morts';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nombre de Blessés',
                    labelText: 'Nombre de Blessés',
                    filled: true,
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    nbrMort = int.parse(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Donner le nombre véhicule impliqué';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'Voies impliquées',
                  hintText: 'Vois impliquées',
                  value: nbrVoieImp,
                  onSaved: (value) {
                    setState(() {
                      nbrVoieImp = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      nbrVoieImp = value;
                    });
                  },
                  dataSource: [
                    {"display":"1", "value":1},
                    {"display":"2", "value":2},
                    {"display":"3", "value":3},
                    {"display":"4", "value":4}
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez le nombre de Voies impliquées';
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
                      print(idEvent);
                      print(heureArriveGen);
                      print(heureDepGen);
                      print(heureArriveSap);
                      print(heureDepSap);
                      print(nbrVehiculeImp);
                      print(nbrBlesse);
                      print(nbrMort);
                      print(nbrVoieImp);
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

