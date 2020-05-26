import 'package:track/screens/events/debaliser_event.dart';
import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';

class EventToDebaliseScreen extends StatefulWidget {
  @override
  _EventToDebaliseScreenState createState() => _EventToDebaliseScreenState();
}

class _EventToDebaliseScreenState extends State<EventToDebaliseScreen> {
  Future eventsToDebalise;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventsToDebalise = getAllEventsToDebalise();
  }

  Future getAllEventsToDebalise(){

    return EvenementService.getAllEventsToDebalise();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Débalisage',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body:Center(
        child: Container(
          child: FutureBuilder(
              future: eventsToDebalise,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return createListView(snapshot.data, context);
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Widget createListView(data, BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Container(
                height: 130,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.outlined_flag,
                                size: 30.0, color: Colors.green),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${data[index]['typeEvenement']}",
                                style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${data[index]['pointKilometrique']} "),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${data[index]['dateDebutEvent']}",
                                style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text("${data[index]['heureDebutEvent']}"),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.indigo,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /*Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.redAccent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                            child: FlatButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {*/
                                    // return DetailCurrentEvent(event:data[index]);
                               /*   }),
                                );
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                              label: Text(
                                'Annuler',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ),*/
                          Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Color(0xFF100D60),
                                //border:Border.all(color: Colors.indigo),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                            child: FlatButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                  return DebaliseEvent(event:data[index]);
                                  }),
                                ).then((_){
                                  setState(() {
                                    eventsToDebalise = getAllEventsToDebalise();
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Débaliser',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  }

