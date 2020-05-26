import 'package:track/data/categories.dart';
import 'package:track/data/autoroutes.dart';
import 'package:track/data/positions.dart';
import 'package:track/data/secteur1.dart';
import 'package:track/data/secteur2.dart';
import 'package:track/data/senss.dart';
import 'package:track/data/typesEvents.dart';
import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  final formatTime = DateFormat("HH:mm");
  String dateTimeString;
  String dateTimeString1;
   var date;
  String timeString;
  String idUser;
  String typeEvenement;
  String autoroute;
  String categorieV;
  String distance;
  String position;
  String sens;
  String typeBalisage;
  String secteur;
  String pk;
  Widget load;
  dynamic annoncerEventResponse;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeString = '';
    date=DateTime.now();
    dateTimeString1=DateTime.now().toIso8601String().substring(0,10);
    timeString = formatTime.format(DateTime.now());
    typeEvenement = '';
    secteur = '';
    position = '';
    sens = '';
    idUser = '';
    categorieV = '';
    typeBalisage = '';
    pk = '';
    load = null;
    initPrefsGetIdUser();
  }

  void initPrefsGetIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('idUser') ?? '' ;
    print('iduser '+idUser);

  }

  void annoncerEvent(BuildContext context) async {
    var response = await EvenementService.annoncerEvent(
        idUser,
        dateTimeString1,
        timeString,
        typeEvenement,
        categorieV,
        typeBalisage,
        secteur,
        position,
        pk = autoroute+" "+distance+" "+sens
    );
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        annoncerEventResponse = response['evenement'];
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Evenement annoncé avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(annoncerEventResponse);
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
      annoncerEvent(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annoncer Evènement'),
      ),
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
                      return DateTimeField.combine(date,time);
                    } else {
                      return currentValue;
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Date et Heure d\'annonce',
                      labelText: 'Date et Heure d\'annonce',
                      prefixIcon: Icon(
                          Icons.date_range
                      )
                  ),
                  initialValue: date,
                  onChanged: (value) {

                    setState(() {
                      date=value;
                    });
                    dateTimeString = format.format(value);
                    dateTimeString1 = value.toIso8601String().substring(0,10);
                    List<String> listDateTime = splitDateTime(dateTimeString);
                    //  dateString = listDateTime[0];
                    timeString = listDateTime[1];

                    print(dateTimeString);
                    print(dateTimeString1);

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
                  titleText: 'Nature de l\'évenement',
                  hintText: 'Selectionnez le type d\' évènement',
                  value: typeEvenement,
                  onSaved: (value) {
                    setState(() {

                      typeEvenement = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      typeEvenement = value;
                    });
                  },
                  dataSource: typesEvents,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez le type d\' évènement';
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
                  titleText: 'Autoroute',
                  hintText: 'Selectionnez l\'axe autoroute',
                  value: autoroute,
                  onSaved: (value) {
                    setState(() {
                      autoroute = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      secteur ="";
                      autoroute = value;
                    });
                  },
                  dataSource: autoroutes,
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
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Distance',
                    labelText: 'Distance 000+000',
                    filled: true,
                    prefixIcon: Icon(Icons.border_color),
                  ),
                  initialValue:distance ,
                  onChanged: (value) {
                    setState(() {
                      distance = value;
                    });

                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Entrez la distance';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'Sens',
                  hintText: 'Entrer le sens',
                  value: sens,
                  onSaved: (value) {
                    setState(() {
                      sens = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      sens = value;
                    });
                  },
                  dataSource: senss,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez le sens';
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
                  titleText: 'Position',
                  hintText: 'Selectionnez la position',
                  value: position,
                  onSaved: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      position = value;
                    });
                  },
                  dataSource: positions,
                  validator: (value) {
                    if (value == null) {
                      return 'Entrez position';
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
                  titleText: 'Categorie',
                  hintText: 'selectionnez la catégorie',
                  value: categorieV,
                  onSaved: (value) {
                    setState(() {
                      categorieV = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      categorieV = value;
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

             autoroute =='A1' ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'Secteur',
                  hintText: 'secteur',
                  value: secteur,
                  onSaved: (value) {
                    setState(() {
                      secteur = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      secteur = value;
                    });
                  },
                  dataSource: secteur1,
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le secteur';
                    }
                    return null;
                  },
                ),
              ):
             autoroute =='A2' ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownFormField(
                  filled: true,
                  titleText: 'Secteur',
                  hintText: 'secteur',
                  value: secteur,
                  onSaved: (value) {
                    setState(() {
                      secteur ='';
                      secteur = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      secteur ='';
                      secteur = value;
                    });
                  },
                  dataSource: secteur2,
                  textField: 'display',
                  valueField: 'value',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le secteur';
                    }
                    return null;
                  },
                ),
              ):Center(child:Text('') ,),
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
                      print(idUser);
                      print(sens);
                      print(typeEvenement);
                      print(dateTimeString1);
                      print(timeString);
                      print(categorieV);
                      pk = autoroute+" "+distance+" "+sens;
                      print(pk);
                      print(position);
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

List<String> splitDateTime(String dateTimeString) {
  List<String> dateTimeList = dateTimeString.split(' ');
  return dateTimeList;
}



