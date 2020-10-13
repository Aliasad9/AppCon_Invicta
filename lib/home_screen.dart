import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'John';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
                'Good Morning, ${name}',style: TextStyle(
              fontFamily: 'Arvo', fontWeight: FontWeight.w700, fontSize: 45
            ),
            )
          ],
        ),
      ),
    );
  }
}
