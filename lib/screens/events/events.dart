import 'package:track/screens/events/event_assister.dart';
import 'package:track/screens/events/event_cours.dart';
import 'package:track/screens/events/event_toDebaliser.dart';
import 'package:track/screens/events/event_toRemork.dart';
import 'package:flutter/material.dart';
import 'package:track/screens/events/events_closed_screen.dart';


class EventScreen extends StatefulWidget {




  @override
  _EventScreenState createState() => _EventScreenState();
}


class _EventScreenState extends State<EventScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in inistate");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
      appBar: AppBar(
        title: Text('Evènements',style: TextStyle(fontSize: 20.0),),
      ),
      body:Container(
        // alignment: Alignment.center,

        child: Column(
          children: <Widget>[

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(10.0),
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Annonce',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF5451A1),),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                 return EventCurrentScreen();
                                }),
                              );

                            },
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.red,
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Assistance',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF5451A1)),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return EventToAssistScreen(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.assistant_photo,
                              color: Colors.orange,
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Remorquage',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color:Color(0xFF5451A1)),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return EventToRemorkScreen(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.build,
                              color: Colors.blue,
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Débalisage',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF5451A1)),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return EventToDebaliseScreen(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.outlined_flag,
                              color: Colors.green,
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Fermés',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF5451A1)),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return EventClosed();
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.blueGrey,
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
