import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:intl/intl.dart';

class TestApi extends StatefulWidget {
  final  employee;
  TestApi({this.employee});

  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
var imageUrl;



String _greetings(){
  var list = ['Birthday','Gift'];
  final _random = new Random();
  var greeting = list[_random.nextInt(list.length)];
  return greeting;
}
  String _getEmployeeEmail(){

   // return this.widget.employee.
  }
  String _getEmployeeName(){

  }
  String placeToCheer(){


    var list = ['McDonalds','Howdy','Hardees','PizzaHut','Dominos','Monal','KFC','OPTP','BurgerKing'];
    final _random = new Random();
    var place = list[_random.nextInt(list.length)];
    return place;
  }
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
    String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  var now = new DateTime.now();

    String _getDate(){

      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      return formattedDate;
    }
    String _getTime(){
      var formatter = new DateFormat("H:m:s");
      String formattedTime = formatter.format(now);
      return formattedTime;
    }
    String _getExpiredDate() {
      String expiryDate = DateTime.now().add(Duration(days: 11)).toString();
      return expiryDate.split(" ")[0];
    }
  String _getExpiredTime() {
    String expiryDate = DateTime.now().add(Duration(days: 11)).toString();
    return expiryDate.split(" ")[1];
  }
Future<void> fetchGiftUp() async {
  final msg= jsonEncode({

    "orderDate": _getDate()+"T"+_getTime()+".000Z",
  "disableAllEmails": false,
  "purchaserEmail": "aqamar.bese18seecs@seecs.edu.pk",
  "purchaserName": "Awais Qamar",
  "itemDetails": [
  {
  "quantity": 1,
  "name": "A "+ _greetings() +"Card! Hurrahyy...",
  "description": "For use at"+placeToCheer(),
  "code": _getRandomString(5),
  "backingType": "Currency",
  "price": 100,
  "value": 120,
  "units": null,
  "equivalentValuePerUnit": null,
  "expiresOn":_getExpiredDate() +"T"+_getExpiredTime()+"Z",
  "expiresInMonths": 0,
  "overrideExpiry": true,
  "sku": "MY-SKU" ,   }
  ],
  "recipientDetails": {
  "recipientName": "Ali Asad" ,
  "recipientEmail": "awais.qa16@gmail.com",
  "message": "Happy "+ _greetings()+"! Cheers...",
  "scheduledFor":_getDate()+"T"+_getTime()+".000Z",
  }

  });
  //String token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJkYzJkODRhMC0yYTY0LTQ2N2YtOTM2MC1kMmE4NGYyZGY5MWYiLCJzdWIiOiJhd2Fpcy5xYTE2QGdtYWlsLmNvbSIsImV4cCI6MTkyMDEwOTYxMSwiaXNzIjoiaHR0cHM6Ly9naWZ0dXAuYXBwLyIsImF1ZCI6Imh0dHBzOi8vZ2lmdHVwLmFwcC8ifQ.wTmXzk2kViZi3In32iNZbuY-rsIIgAsxWIZwnoKRJ80";
  http.Response response = await http.post("https://api.giftup.app/orders/",
      headers: {
        'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlYmY0ZGExNC01NGJiLTQ1MTctYjRiZC04YzNhZjYyMzRhYmQiLCJzdWIiOiJhbGlhc2FkNjUyMUBnbWFpbC5jb20iLCJleHAiOjE5MjA0MzcwNzIsImlzcyI6Imh0dHBzOi8vZ2lmdHVwLmFwcC8iLCJhdWQiOiJodHRwczovL2dpZnR1cC5hcHAvIn0.N-17aBufwWK5biyuqskuOqxUhKj6GwJdUwI08_A1F34",
        'Accept': 'application/json',
        'x-giftup-testmode': 'true',
        'Content-Type': 'application/json',
      },
    body: msg,

  );


  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var dataDecoded = jsonDecode(response.body);
     imageUrl = dataDecoded['downloadLinks']['single']['imageUrl'];
    print(imageUrl);




  } else {
    print(jsonDecode(response.body));
    print("hi");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load gift card');
  }
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
        child: Column(
          children: [
            Expanded(child: Image.network(imageUrl)),


            RaisedButton(
              child: Text("Api test"),
              onPressed: ()  {
                fetchGiftUp();


              },
            ),
          ],
        )




        ),
      ),
    );
  }

}


//HttpHeaders.authorizationHeader
