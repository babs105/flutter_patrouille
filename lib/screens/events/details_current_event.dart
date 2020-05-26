import 'package:track/constants/constants_style.dart';
import 'package:flutter/material.dart';

class DetailCurrentEvent extends StatelessWidget {
  final dynamic event;

  DetailCurrentEvent({this.event});

  void reloadCurrentEvent() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails Evenements'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Date',
                style: kDetailCurrentEventTitle,
              ),
              Text(event['dateDebutEvent'], style: kDetailCurrentEventContent),
              SizedBox(
                height: 15,
              ),
              Text(
                'Nature Evènement',
                style: kDetailCurrentEventTitle,
              ),
              Text(event['typeEvenement'], style: kDetailCurrentEventContent),
              SizedBox(
                height: 15,
              ),
              Text(
                'Heure Annoncée',
                style: kDetailCurrentEventTitle,
              ),
              Text(event['heureDebutEvent'], style: kDetailCurrentEventContent),
              SizedBox(
                height: 15,
              ),
              Text(
                'PK',
                style: kDetailCurrentEventTitle,
              ),
              Text(event['pointKilometrique'],
                  style: kDetailCurrentEventContent),
              SizedBox(
                height: 15,
              ),
              Text(
                'Categorie',
                style: kDetailCurrentEventTitle,
              ),
              Text(event['categorieV'], style: kDetailCurrentEventContent),
              SizedBox(
                height: 15,
              ),
              Text(
                'Secteur',
                style: kDetailCurrentEventTitle,
              ),
              Text(
                event['secteur'],
                style: kDetailCurrentEventContent,
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 5.0,
                color: Colors.blue,
              ),
            /*  Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BaliserEvent(event: event);
                      }),
                    ).then((_) {
                      print('back event');

                      return EventCurrentScreen();
                    });
                  },
                  child: Text(
                    'Baliser',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
