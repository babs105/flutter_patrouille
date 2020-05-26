import 'package:flutter/material.dart';

class AnnulerEvent extends StatefulWidget {
  final event;
  AnnulerEvent({this.event});
  @override
  _AnnulerEventState createState() => _AnnulerEventState();
}

class _AnnulerEventState extends State<AnnulerEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        Text('Annuler Evenement'),),
    );
  }
}


