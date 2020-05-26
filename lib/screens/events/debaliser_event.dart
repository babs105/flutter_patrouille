import 'package:track/services/evenement_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DebaliseEvent extends StatefulWidget {
  final event;
  DebaliseEvent({this.event});
  @override
  _DebaliseEventState createState() => _DebaliseEventState();
}

class _DebaliseEventState extends State<DebaliseEvent> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String dateString;
  String idEvent;
  String timeString;
  Widget load;
  dynamic eventToDebaliseResponse;


  @override
  void initState() {
    super.initState();
    idEvent = widget.event['id'];
    print(idEvent);
    dateTimeString = '';
    dateString = '';
    timeString = '';
    load = null;
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


  void debaliserEvent(BuildContext context) async {

    var response = await EvenementService.debaliserEvent(
        idEvent,
        dateTimeString1,
        timeString
    );
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        eventToDebaliseResponse = response['evenement'];


        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Evenement débalisé avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(eventToDebaliseResponse);
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
      debaliserEvent(context);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Débaliser'),
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
                      print(dateTimeString1);
                      print(timeString);

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
              Center(
                child: Container(
                  child: load,
                ),
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
