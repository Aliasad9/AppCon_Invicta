import 'package:flutter/material.dart';
import 'package:uiauth/teams.dart';
class Heading extends StatelessWidget {
  final String text;
  Heading(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(text,
      style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          fontFamily: "Arvo-Bold",
        ),
      ),
    );
  }
}
