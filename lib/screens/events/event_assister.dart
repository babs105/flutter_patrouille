import 'package:track/screens/events/assister_accident.dart';
import 'package:track/screens/events/baliser_accident.dart';
import 'package:track/screens/events/debaliser_event.dart';
import 'package:track/screens/events/sendToRemork_event.dart';
import 'package:track/services/evenement_service.dart';
import 'package:flutter/material.dart';

class EventToAssistScreen extends StatefulWidget {
  @override
  _EventToAssistScreenState createState() => _EventToAssistScreenState();
}

class _EventToAssistScreenState extends State<EventToAssistScreen> {
  Future eventsToAssist;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventsToAssist = getAllEventsToAssist();
  }

  Future getAllEventsToAssist() {
    return EvenementService.getAllEventsToAssist();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
      appBar: AppBar(
        title: Text(
          "Assistance",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: eventsToAssist,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.assistant_photo,
                                size: 30.0, color: Colors.orangeAccent),
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
                              Text("${data[index]['balisage']['categorieVBalise']} "),
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
                         data[index]['typeEvenement'] =='ACCIDENT'?
                                Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[
                            /* Container(
                               height:30.0 ,
                               decoration:BoxDecoration(

                                   color: Colors.white,
                                   border:Border.all(color: Colors.indigo),
                                   borderRadius: BorderRadius.all(Radius.circular(10.0),)
                               ) ,
                              child:FlatButton.icon(
                                 onPressed:(){
                                   Navigator.push(context, MaterialPageRoute(builder:(context){
                                     return ToRemorkEvent(event:data[index]);
                                   }),
                                   ).then((_){
                                     setState(() {
                                       eventsToAssist = getAllEventsToAssist();
                                     });
                                   });
                                 },
                                 icon:Icon(Icons.send ,color:Colors.indigo ,) ,
                                 label:Text('A remorquer',style:TextStyle(color: Colors.indigo)),


                               )
                             ),*/


                             Container(
                               height:30.0 ,
                               decoration:BoxDecoration(

                                   color: Color(0xFF100D60),
                                   //border:Border.all(color: Colors.indigo),
                                   borderRadius: BorderRadius.all(Radius.circular(10.0),)
                               ) ,
                               child:FlatButton.icon(
                                 onPressed:(){
                                   Navigator.push(context, MaterialPageRoute(builder:(context){
                                     return AssisterAccident(event:data[index]);
                                   }),
                                   ).then((_){

                                     setState(() {
                                       eventsToAssist = getAllEventsToAssist();
                                     });
                                   });
                                 },
                                 icon:Icon(Icons.edit ,color:Colors.white ,) ,
                                 label:Text('Assister',style:TextStyle(color: Colors.white)),


                               ),
                             ),

                           ],
                         )
                             :Text(''),




                      data[index]['typeEvenement'] =='PANNE'?
                            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                                  return ToRemorkEvent(event:data[index]);
                                }),
                                ).then((_){
                                  setState(() {
                                    eventsToAssist = getAllEventsToAssist();
                                  });
                                });
                              },
                              icon:Icon(Icons.send ,color:Colors.indigo ,) ,
                              label:Text('A remorquer',style:TextStyle(color: Colors.indigo)),


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
                                Navigator.push(context, MaterialPageRoute(builder:(context){
                                return DebaliseEvent(event:data[index]);
                                }),
                                ).then((_){

                                  setState(() {
                                    eventsToAssist = getAllEventsToAssist();
                                  });
                                });
                              },
                              icon:Icon(Icons.edit ,color:Colors.white ,) ,
                              label:Text('Débaliser',style:TextStyle(color: Colors.white)),


                            ),
                          ),

                        ],
                      )
                          :Text(''),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }


}

