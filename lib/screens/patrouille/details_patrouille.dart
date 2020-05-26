import 'package:flutter/material.dart';

class DetailsPatrouille extends StatefulWidget {
  final patrouille;
  DetailsPatrouille({this.patrouille});

  @override
  _DetailsPatrouilleState createState() => _DetailsPatrouilleState();
}

class _DetailsPatrouilleState extends State<DetailsPatrouille> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails Patrouille'),
        centerTitle: true,
      ),
    );
  }
}
