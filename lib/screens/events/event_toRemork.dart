import 'package:track/screens/events/annuler_event_remork.dart';
import 'package:track/screens/events/remorquer_event.dart';
import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';

class EventToRemorkScreen extends StatefulWidget {
  @override
  _EventToRemorkScreenState createState() => _EventToRemorkScreenState();
}

class _EventToRemorkScreenState extends State<EventToRemorkScreen> {
  Future eventsToRemork;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventsToRemork = getAllEventsToRemork();
  }

  Future getAllEventsToRemork() {
    return EvenementService.getAllEventsToRemork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
      appBar: AppBar(
        title: Text(
          'Remorquage',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: eventsToRemork,
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
                            child: Icon(Icons.build,
                                size: 30.0, color: Colors.blue),
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
                          Container(
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
                                  MaterialPageRoute(builder: (context) {
                                    return AnnulerRemorkEvent(event:data[index]);
                                  }),
                                ).then((_){
                                  setState(() {
                                    eventsToRemork = getAllEventsToRemork();
                                  });
                                });
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
                          ),
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
                                    return RemorquerEvent(event:data[index]);
                                  }),
                                ).then((_){

                                  setState(() {
                                    eventsToRemork = getAllEventsToRemork();
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Remorquer',
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
