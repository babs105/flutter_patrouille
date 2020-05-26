import 'package:flutter/material.dart';

class DetailsEventClosed extends StatelessWidget {
  final dynamic event;

  DetailsEventClosed({this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
      appBar: AppBar(
        title: Text('Détails Evènements fermés'),
      ),
      body: Center(
        child: Container(
          padding:EdgeInsets.all(20.0),
          child: ListView(
            children:<Widget>[
              Column(
                children: <Widget>[
                  Text('EVENEMENT',style:TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  Divider(height: 10.0,color:Colors.indigo),
                  Text('Date Heure Début :',),
                  Text('${event['dateDebutEvent']} ${event['heureDebutEvent']}',style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

                  Text('Date Heure Fin :'),
                  Text('${event['dateFinEvent']} ${event['heureFinEvent'] ?? "undefined"}',style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

                  Text('Nature Evenement:'),
                  Text(event['typeEvenement'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

                  Text('Categorie:'),
                  Text(event['balisage']['categorieVBalise'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

                  Text('Matricule:'),
                  Text(event['balisage']['matriculeVehicule'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

                  Text('PK:',),
                  Text(event['pointKilometrique'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  Text('Secteur:'),
                  Text(event['secteur'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  Divider(height: 10.0,color:Colors.indigo),
                  Text('BALISAGE',style:TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  Divider(height: 10.0,color:Colors.indigo),

                  Text('Heure Balisage'),
                  Text(event['balisage']['heureBalisage'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  Text('Heure DéBalisage'),
                  Text(event['balisage']['heureDeBalisage'],style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),

               event['etatRemorquage']==true?
                Column(
                  children: <Widget>[
                    Divider(height: 10.0,color:Colors.indigo),
                    Text('REMORQUAGE',style:TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                    Divider(height: 10.0,color:Colors.indigo),
                    Text('Date Remorquage'),
                    Text("${event['remorquage']['dateRemorquage'] ??'N/A'}",style:TextStyle(color: Colors.blue,fontSize: 18.0,fontWeight:FontWeight.bold) ,),
                    Text('Heure Remorquage'),
                    Text("${event['remorquage']['heureRemorquage'] ??'N/A'}",style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                    Text('Dépanneur'),
                    Text("${event['remorquage']['remorqueur'] ??'N/A'}",style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                    Text('Remorque'),
                    Text("${event['remorquage']['matriculeRemorque'] ??'N/A'}",style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                    Text('Gare Depot'),
                    Text("${event['remorquage']['gareDepot']??'N/A'}",style:TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight:FontWeight.bold) ,),
                  ],
                )
                :Text(''),
                ],
              ),
            ]
    ),

          ),

      ),
    );
  }
}
