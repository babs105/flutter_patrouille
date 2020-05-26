import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:track/constants/constants_network.dart' show baseURL;



class EvenementService {

 static Future <dynamic> getAllEvenementTerminer() async {
   print('future method getevent terminer');

     http.Response response = await http.get('$baseURL/evenement/getAllEvenementTerminer');
    // if (response.statusCode == 200) {
       String data = response.body;

       var jsonObject = jsonDecode(data);
       return jsonObject;

   //  } else {
       //print(response.statusCode);
   //  }


 }
 static Future <dynamic> getAllCurrentEvenement() async {
   http.Response response = await http.get('$baseURL/evenement/getAllEvenementEnCoursNoBaliser');
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

   //  } else {
   //print(response.statusCode);
   //  }


 }
 static Future <dynamic> getAllEventsToAssist() async {
   print('future method to assist');

   http.Response response = await http.get('$baseURL/evenement/getAllEvenementEnCoursToAssister');
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

   //  } else {
   //print(response.statusCode);
   //  }


 }
 static Future <dynamic> getAllEventsToRemork() async {
   print('future method to remork');

   http.Response response = await http.get('$baseURL/evenement/getAllEvenementEnCoursToRemorquer');
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

   //  } else {
   //print(response.statusCode);
   //  }


 }
 static Future <dynamic> getAllEventsToDebalise() async {
   print('future method to debalise');

   http.Response response = await http.get('$baseURL/evenement/getAllEvenementAdeBaliser');
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

   //  } else {
   //print(response.statusCode);
   //  }


 }
 static Future <dynamic> baliserEvent(String idEvent, String idPatrouille, String heureBalisage, String todo,String originePanne ,String categorie, String matriculeVehicule) async {
   print('future method getevent terminer');

   http.Response response = await http.post('$baseURL/evenement/baliserEvent'
   ,body:json.encode(
           {

             "idEvent":idEvent,
             "idPatrouille":idPatrouille,
             "heureBalisage":heureBalisage,
             "operation":todo,
             "originePanne":originePanne,
             "categorieVBalise":categorie,
             "matriculeVehicule":matriculeVehicule
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

   //  } else {
   //print(response.statusCode);
   //  }


 }
 static Future <dynamic> debaliserEvent(String idEvent, String dateDeBalisage, String heureDeBalisage,) async {
   print('future method getevent debaliser');

   http.Response response = await http.post('$baseURL/evenement/deBaliserEvent'
       ,body:json.encode(
           {

             "idEvent":idEvent,
             "dateDeBalisage":dateDeBalisage,
             "heureDeBalisage":heureDeBalisage,

           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }
 static Future <dynamic> toRemork(String idEvent, String action) async {
   print('future method getevent toRemork');

   http.Response response = await http.post('$baseURL/evenement/toRemorkEvent'
       ,body:json.encode(
           {

             "idEvent":idEvent,
             "action":action,
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }

 static Future <dynamic> remorker(
     String idEvent,
     String date,
     String idUser,
     String heureRemorquage,
     String heureDarriveRemorque,
     String matriculeRemorque,
     String gareDepot
     ) async {
   print('future method getevent Remork');

   http.Response response = await http.post('$baseURL/evenement/remorkVehicule'
       ,body:json.encode(
           {
             "idEvent":idEvent,
             "dateRemorquage":date,
             "idUser":idUser,
             "heureRemorquage":heureRemorquage,
             "heureDarriveRemorque":heureDarriveRemorque,
             "matriculeRemorque":matriculeRemorque,
             "gareDepot": gareDepot,
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }
 static Future <dynamic> annulerRemork(
     String idEvent,
     String action,
     String date,
     String heureDarriveRemorque,
     String matriculeRemorque,
     String idUser,
     String motif
     ) async {
   print('future method annuler  Remork');

   http.Response response = await http.post('$baseURL/evenement/annulerRemorquage'
       ,body:json.encode(
           {
               "idEvent":idEvent,
               "action":action,
               "dateRemorquage":date,
               "heureDarriveRemorque":heureDarriveRemorque,
               "matriculeRemorque":matriculeRemorque,
               "idUser":idUser,
               "motif":motif
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }

 static Future <dynamic> annoncerEvent(
     String idUser,
     String debutEvent,
     String heureOuvertureEvement,
     String typeEvenement,
     String categorieV,
     String typeBalisage,
     String secteur,
     String position,
     String pk
     ) async {
   print('future method annoncer event');

   http.Response response = await http.post('$baseURL/evenement/openEvent'
       ,body:json.encode(
           {
             "idUser":idUser,
             "debutEvent":debutEvent,
             "heureOuvertureEvement":heureOuvertureEvement,
             "typeEvenement":typeEvenement,
             "categorieV" :categorieV,
             "typeBalisage":typeBalisage,
             "secteur":secteur,
             "position":position,
             "pointKilometrique":pk
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }
 static Future <dynamic> assisterAccident(
     String idEvent,
     String heureArriveGen,
     String heureDepGen,
     String heureDepSap,
     String heureArriveSap,
     int nbrVoieImplique,
     int nbBlesse,
     int nbMort,
     int nbVehiculeImp
     ) async {
   print('future method annoncer event');

   http.Response response = await http.post('$baseURL/evenement/assisterAccident'
       ,body:json.encode(
           {
             "idEvent":idEvent,
             "heureArriveGen":heureArriveGen,
             "heureDepGen":heureDepGen,
             "heureDepSap":heureDepSap,
             "heureArriveSap":heureArriveSap,
             "nbrVoieImplique":nbrVoieImplique,
             "nbBlesse":nbBlesse,
             "nbMort":nbMort,
             "nbVehiculeAccidente":nbVehiculeImp
           }),
       headers: {
         HttpHeaders.contentTypeHeader: 'application/json',
       });
   // if (response.statusCode == 200) {
   String data = response.body;

   var jsonObject = jsonDecode(data);
   return jsonObject;

 }
}

