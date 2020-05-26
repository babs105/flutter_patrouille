import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:track/constants/constants_network.dart';


class PatrouilleService {

  static Future <dynamic> getAllCurrentPatrouille() async {
    print('future method getevent terminer');

    http.Response response = await http.get(
        '$baseURL/patrouiller/getAllPatrouillerEnCours');
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }

  }

  static Future <dynamic> debuterPatrouille(
      String date,
      String matricule,
      String heureDebutPatrouille,
      int kilometrageDebutPatrouille,
      String itineraire,
      String matriculePat1,
      String matriculePat2) async {
    print('future method getevent terminer');

    http.Response response = await http.post(
        '$baseURL/patrouiller/debuter',
        body:json.encode(
        {
        "date": date,
        "matricule": matricule,
        "heureDebutPatrouille": heureDebutPatrouille,
        "kilometrageDebutPatrouille": kilometrageDebutPatrouille,
        "itineraire":itineraire,
        "matriculePat1":matriculePat1,
        "matriculePat2":matriculePat2
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

  static Future <dynamic> terminerPatrouille(
      String idPatrouille,
      String date,
      String heureFinPatrouille,
      int kilometrageFinPatrouille,

      ) async {
    print('future method  terminer patrouille');

    http.Response response = await http.post(
        '$baseURL//patrouiller/terminer',
        body:json.encode(
            {
              "idPatrouille":idPatrouille,
              "dateFin":date,
              "heureFinPatrouille":heureFinPatrouille,
              "kilometrageFinPatrouille":kilometrageFinPatrouille
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
  }