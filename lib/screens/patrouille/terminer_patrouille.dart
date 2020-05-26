import 'package:track/services/patrouille_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerminerPatrouille extends StatefulWidget {
  final patrouille ;
  TerminerPatrouille({this.patrouille});
  
  @override
  _TerminerPatrouilleState createState() => _TerminerPatrouilleState();
}

class _TerminerPatrouilleState extends State<TerminerPatrouille> {


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String dateString;
  String timeString;
  String heureFinPatrouille;
  int kilometrageFinPatrouille;
  String idPatrouille;
  Widget load;
  dynamic terminerPatrouilleResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeString1 = '';
    dateString = '';
    heureFinPatrouille = '';
    kilometrageFinPatrouille= 0;
    idPatrouille = widget.patrouille['id'];

    load = null;
  }

  void terminerPatrouille(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var response = await PatrouilleService.terminerPatrouille(
        idPatrouille,
        dateTimeString1,
        heureFinPatrouille,
        kilometrageFinPatrouille
    );
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        terminerPatrouilleResponse = response['patrouille'];
        prefs.remove('idPatrouille');

        //print('store idpat   '+prefs.getString('idPatrouille'));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Patrouille terminée avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(terminerPatrouilleResponse);
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
      terminerPatrouille(context);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminer Patrouille'),
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
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Date et Heure Fin patrouille',
                      labelText: 'Date et Heure Fin Patrouille',
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
                    heureFinPatrouille = listDateTime[1];
                    print(dateString);
                    print(heureFinPatrouille);
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
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Fin Kilometrage',
                      labelText: 'Kilometrage Fin Patrouille',
                      filled: true,
                      prefixIcon: Icon(
                          Icons.slow_motion_video
                      )
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    kilometrageFinPatrouille = int.parse(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Entrez le kilometrage Fin';
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
                      print(dateTimeString1);
                      print(heureFinPatrouille);
                      print(dateTimeString);
                      print(kilometrageFinPatrouille);

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
