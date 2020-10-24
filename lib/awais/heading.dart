import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  Heading(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Arvo',
        fontWeight: FontWeight.w700,
        fontSize: 45,
      ),
    );
  }
}
