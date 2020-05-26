import 'package:track/screens/events/add_events.dart';
import 'package:track/screens/events/annuler_event.dart';
import 'package:track/screens/events/baliser_accident.dart';
import 'package:track/screens/events/baliser_event.dart';
import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';

class EventCurrentScreen extends StatefulWidget {
  final bool reload;
  EventCurrentScreen({this.reload});

  @override
  _EventCurrentScreenState createState() => _EventCurrentScreenState();
}

class _EventCurrentScreenState extends State<EventCurrentScreen> {
  Future eventsCurrent;

  @override
  void initState() {
    super.initState();
    eventsCurrent = getAllCurrentEvent();
    print("ini current event state");
  }

  Future getAllCurrentEvent() {
    return EvenementService.getAllCurrentEvenement();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reload == true) {
      setState(() {
        print("reload");
        eventsCurrent = getAllCurrentEvent();
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
     // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          'Evènements Annoncés',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddEvent();
          })).then((_){
            setState(() {
              eventsCurrent = getAllCurrentEvent();
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Container(
         // color: Colors.white,
          child: FutureBuilder(
              future: eventsCurrent,
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
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(

                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(

                            child: Icon(Icons.notifications_active,
                                size: 30.0, color: Colors.red),
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
                                Text("${data[index]['categorieV']} "),
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
                   Divider(height:2.0 ,color:Colors.indigo ,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                    /*      Container(
                            height:30.0 ,
                            decoration:BoxDecoration(

                                color: Colors.white,
                                border:Border.all(color: Colors.indigo),
                                borderRadius: BorderRadius.all(Radius.circular(10.0),)
                            ) ,
                            child:FlatButton.icon(
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder:(context){
                                  return DetailCurrentEvent(event:data[index]);
                                }),
                                );
                              },
                              icon:Icon(Icons.remove_red_eye ,color:Colors.indigo ,) ,
                              label:Text('Détails',style:TextStyle(color: Colors.indigo)),


                            ),
                          ),*/
                          Container(
                            height:30.0 ,
                            decoration:BoxDecoration(

                                color: Colors.white,
                                border:Border.all(color: Colors.indigo),
                                borderRadius: BorderRadius.all(Radius.circular(10.0),)
                            ) ,
                            child:FlatButton.icon(
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder:(context){
                                  return AnnulerEvent(event:data[index]);
                                }),
                                );
                              },
                              icon:Icon(Icons.cancel ,color:Colors.red ,) ,
                              label:Text('Annuler',style:TextStyle(color: Colors.indigo)),


                            ),
                          ),

                          Container(
                            height:30.0 ,
                            decoration:BoxDecoration(

                                color: Color(0xFF100D60),
                                //border:Border.all(color: Colors.indigo),
                                borderRadius: BorderRadius.all(Radius.circular(10.0),)
                            ) ,
                            child:FlatButton.icon(
                              onPressed:(){
                                if(data[index]['typeEvenement']=='PANNE'){
                                  Navigator.push(context, MaterialPageRoute(builder:(context){
                                    return BaliserEvent(event:data[index]);
                                  }),
                                  ).then((_){
                                    setState(() {
                                      eventsCurrent = getAllCurrentEvent();
                                    });
                                  });
                                }
                                if(data[index]['typeEvenement']=='ACCIDENT'){
                                  Navigator.push(context, MaterialPageRoute(builder:(context){
                                    return BaliserAccident(event:data[index]);
                                  }),
                                  ).then((_){
                                    setState(() {
                                      eventsCurrent = getAllCurrentEvent();
                                    });
                                  });
                                }

                              },

                              icon:Icon(Icons.edit ,color:Colors.white ,) ,
                              label:Text('Baliser',style:TextStyle(color: Colors.white)),


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
