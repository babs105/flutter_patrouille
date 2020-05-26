import 'package:track/screens/events/details_events_closed.dart';
import 'package:flutter/material.dart';
import 'package:track/services/evenement_service.dart';



class EventClosed extends StatefulWidget {

  //final eventListClosed;

  //EventClosed({this.eventListClosed});

  @override
  _EventClosedState createState() => _EventClosedState();
}

class _EventClosedState extends State<EventClosed> {


  Future<dynamic> data;

  @override
  void initState() {
    super.initState();
    print('in init state');
   data = getAllClosedEvent();
  }

  Future<dynamic> getAllClosedEvent() async {
   print('in method getALL');
     return EvenementService.getAllEvenementTerminer();

  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,int index ){
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailsEventClosed(event:data[index]);
            }),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color:Colors.white ,
                child: ListTile(
                  title: Text(
                    "${data[index]['typeEvenement']}",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),

                  ),
                  subtitle:Text("${data[index]['pointKilometrique']}")
                  ,
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.indigo,
                        radius: 23.0,
                        child:Text("${data[index]['categorieV']}",style: TextStyle(color: Colors.white),
                        ),
                      )],
                  ),
                  trailing: Text("${ data[index]['dateDebutEvent']}") ,
                ),
              ),
            ],
          ),
        );
    }),
    );
  }
  @override
  Widget build(BuildContext context) {
    print('in builde');
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
     appBar: AppBar(
        title: Text(
            'Evènements Terminés'
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: FutureBuilder(
              future:getAllClosedEvent(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return createListView(snapshot.data,context);
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }




}
