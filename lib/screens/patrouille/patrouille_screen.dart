import 'package:track/screens/patrouille/add_patrouille.dart';
import 'package:track/screens/patrouille/details_patrouille.dart';
import 'package:track/screens/patrouille/terminer_patrouille.dart';
import 'package:track/services/patrouille_services.dart';
import 'package:flutter/material.dart';

class PatrouilleScreen extends StatefulWidget {
  final loginResponse;

  PatrouilleScreen({this.loginResponse});
  @override
  _PatrouilleScreenState createState() => _PatrouilleScreenState();
}

class _PatrouilleScreenState extends State<PatrouilleScreen> {


Future patrouilleCurrents;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    patrouilleCurrents = getAllCurrentPatrouille();
  }

Future getAllCurrentPatrouille(){
    return PatrouilleService.getAllCurrentPatrouille();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F1),
      appBar: AppBar(
        backgroundColor:Color(0xFF5451A1) ,
        title: Text('Patrouilles',),
        centerTitle: true,
      ),
      body:Center(
        child: Container(
          child: FutureBuilder(
              future:getAllCurrentPatrouille(),
              builder: (context, AsyncSnapshot snapshot){

                if(snapshot.hasData){
                  return createListView(snapshot.data,context);
                }
                return CircularProgressIndicator();
              }),
        ),
      ) ,
      floatingActionButton:FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddPatrouille(loginResponse: widget.loginResponse,);


          }),
          );
            /*  .then((_)  {

            setState(() {
              patrouilleCurrents = getAllCurrentPatrouille();
            });

          });*/
        } ,
        backgroundColor: Colors.pinkAccent,
        child:Icon(Icons.add) ,
      )
    );
  }

  Widget createListView(data, BuildContext context) {
    return Container(
      child: Padding(
        padding:EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,int index ){
              return Container(
                height:110.0 ,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color:Colors.grey ,style:BorderStyle.solid ,width:0.5 ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,

                        children: <Widget>[
                          Container(
                            child:Icon(Icons.local_shipping,size: 30.0,color:Colors.indigo) ,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${data[index]['matriculeVehicule']}",style:TextStyle(color:Colors.indigoAccent,fontSize:20.0,fontWeight: FontWeight.bold),),
                              Text("${data[index]['kilometrageDebutPatrouille']} km"),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${data[index]['dateDebut']}",style:TextStyle(color:Colors.indigoAccent,fontSize:18.0,fontWeight: FontWeight.w800),),
                              Text("${data[index]['heureDebutPatrouille']}"),

                            ],
                          ),
                        ],
                      ),
                    ),

                    Divider(height:2.0 ,color:Colors.indigo ,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,

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
                                 return DetailsPatrouille(patrouille:data[index]);
                                }),
                                );

                              },
                              icon:Icon(Icons.remove_red_eye ,color:Colors.indigo ,) ,
                              label:Text('Détails',style:TextStyle(color: Colors.indigo)),


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
                                  return TerminerPatrouille(patrouille:data[index]);
                                }),
                                ).then((_){
                                  setState(() {
                                   patrouilleCurrents = getAllCurrentPatrouille();
                                  });
                                });
                              },
                              icon:Icon(Icons.close ,color:Colors.white ,) ,
                              label:Text('Terminer',style:TextStyle(color: Colors.white)),


                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),

                );

            }),
      ),

    );



  }
}
