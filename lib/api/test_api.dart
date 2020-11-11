import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  Future<Giftup> futureGiftup;
  @override
  void initState() {
    super.initState();
    futureGiftup = fetchGiftup();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(


          child: FutureBuilder<Giftup>(
            future: futureGiftup,

            builder: (context, snapshot) {
               if (snapshot.hasData) {
                print("future");

                return Text( snapshot.data.title+snapshot.data.subtitle+snapshot.data.message);

              } else if (snapshot.hasError) {
                print("upper block");
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
class Giftup {
  final String title;
  final String subtitle;
  final String message;

  Giftup({this.title, this.subtitle, this.message});

  factory Giftup.fromJson(Map<String, dynamic> json) {
    return Giftup(
      title: json['title'],
      subtitle: json['subtitle'],
      message: json['message'],
    );
  }
}
//HttpHeaders.authorizationHeader
Future<Giftup> fetchGiftup() async {
  String token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJkYzJkODRhMC0yYTY0LTQ2N2YtOTM2MC1kMmE4NGYyZGY5MWYiLCJzdWIiOiJhd2Fpcy5xYTE2QGdtYWlsLmNvbSIsImV4cCI6MTkyMDEwOTYxMSwiaXNzIjoiaHR0cHM6Ly9naWZ0dXAuYXBwLyIsImF1ZCI6Imh0dHBzOi8vZ2lmdHVwLmFwcC8ifQ.wTmXzk2kViZi3In32iNZbuY-rsIIgAsxWIZwnoKRJ80";
 http.Response response = await http.get("https://api.giftup.app/gift-cards/${"string"}",
   headers: {
     'Authorization': "Bearer $token",
     'Accept': 'application/json',
     'x-giftup-testmode': 'true',
     'Content-Type': 'application/json',
   }
 );
 print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print( Giftup.fromJson(jsonDecode(response.body)));
  } else {
    print(jsonDecode(response.body));
    print("hi");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load gift card');
  }
}