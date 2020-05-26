import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor:Color(0xFF5451A1) ,
      ),
  debugShowCheckedModeBanner: false,

     // home: EventCurrentScreen()
   home: LoginScreen()
     // home: AddPatrouille(),
    );
  }
}
