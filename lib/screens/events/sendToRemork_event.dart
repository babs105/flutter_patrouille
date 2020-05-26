import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';

class ToRemorkEvent extends StatefulWidget {
  final event;

  ToRemorkEvent({this.event});

  @override
  _ToRemorkEventState createState() => _ToRemorkEventState();
}

class _ToRemorkEventState extends State<ToRemorkEvent> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String idEvent;
  String action;
  Widget load;
  dynamic eventToRemorkResponse;


  @override
  void initState() {
    super.initState();
    idEvent = widget.event['id'];
    print(idEvent);
    action = 'remorquer';
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


  void toRemork(BuildContext context) async {

    var response = await EvenementService.toRemork(idEvent, action);
    print(response);

    if (response['error'] == false) {
      setState(() {
        load = null;
        eventToRemorkResponse = response['evenement'];


        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Evenement à Remorquer avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(eventToRemorkResponse);
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
      toRemork(context);

    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Remorquer'),
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
                child: TextFormField(
                  decoration: InputDecoration(
                    // icon:Icon(Icons.person),
                      hintText: 'Remorquer',
                      labelText: 'A Remorquer',
                      prefixIcon: Icon(
                          Icons.check_box
                      )
                  ),
                  initialValue: action,
                  readOnly: true,
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
                      print(action);
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
      }) ,
    );
  }
}
