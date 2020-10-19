import 'package:flutter/material.dart';
class NameNumber extends StatelessWidget {
  final String text;
  final String  number;
  NameNumber(this.text,this.number);
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:22.0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Oswald"),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),

          height: 30,
          width: 30,
          // color: Colors.blue,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16.0),
          child: new Text(
            number,
            style: new TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
