import 'dart:io';
import 'package:track/constants/constants_network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class AuthenService {
 static Future<dynamic> login(String username, String pwd) async {
    http.Response response = await http.post('$baseURL/users/authenticate',
        body:json.encode({'username': username, 'password': pwd}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
        );
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }
  }

 static Future<dynamic> register() async {
    http.Response response = await http.get('$baseURL/users/create');
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }
  }
}
