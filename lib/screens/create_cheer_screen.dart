import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Invicta/data/cheer.dart';
import 'package:Invicta/data/notification.dart';
import 'package:Invicta/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:math';
import 'package:intl/intl.dart';
import '../widgets/heading.dart';

class CreateCheerScreen extends StatefulWidget {
  final List<CustomUser> teamList;
  final employee;

  CreateCheerScreen({this.teamList, this.employee});

  @override
  _CreateCheerScreenState createState() => _CreateCheerScreenState();
}

class _CreateCheerScreenState extends State<CreateCheerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _messageTextController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;

  List<Category> _companies = Category.getCategory();
  List<DropdownMenuItem<Category>> _dropdownMenuItemsCategory;
  Category _selectedCompany;

  List<CustomUser> _employees;
  List<DropdownMenuItem<CustomUser>> _dropdownMenuItemsEmployee;
  CustomUser _selectedEmployee;

  bool _isBlueChecked = true;
  bool _isRedChecked = false;
  bool _isTealChecked = false;
  bool _isOrangeChecked = false;
  bool _isPurpleChecked = false;
  Color textFieldColor = Colors.blue;
  int cheerType = 1;
  var imageUrl;
  var senderEmail;
  var receiverEmail;



  @override
  void dispose() {
    _formKey.currentState.dispose();
    _messageTextController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (this.widget.teamList != null) {
      _employees = this.widget.teamList;
      _dropdownMenuItemsEmployee = buildDropdownMenuItemsEmployee(_employees);
      _selectedEmployee = _dropdownMenuItemsEmployee[0].value;
    }
    _dropdownMenuItemsCategory = buildDropdownMenuItemsCategory(_companies);
    _selectedCompany = _dropdownMenuItemsCategory[0].value;


    super.initState();
  }

  String placeToCheer() {
    var list = [
      'McDonalds',
      'Howdy',
      'Hardees',
      'PizzaHut',
      'Dominos',
      'Monal',
      'KFC',
      'OPTP',
      'BurgerKing'
    ];
    final _random = new Random();
    var place = list[_random.nextInt(list.length)];
    return place;
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  var now = new DateTime.now();

  String _getDate() {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String _getTime() {
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

  Future<void> fetchGiftUp(String senderName, String receiverName,
      String senEmail, String recEmail) async {
    final msg = jsonEncode({
      "orderDate": _getDate() + "T" + _getTime() + ".000Z",
      "disableAllEmails": false,
      "purchaserEmail": senEmail,
      "purchaserName": senderName,
      "itemDetails": [
        {
          "quantity": 1,
          "name": "A Gift Card! Hurrah...",
          "description": "For use at " + placeToCheer(),
          "code": _getRandomString(5),
          "backingType": "Currency",
          "price": 100,
          "value": 120,
          "units": null,
          "equivalentValuePerUnit": null,
          "expiresOn": _getExpiredDate() + "T" + _getExpiredTime() + "Z",
          "expiresInMonths": 0,
          "overrideExpiry": true,
          "sku": "MY-SKU",
        }
      ],
      "recipientDetails": {
        "recipientName": receiverName,
        "recipientEmail": recEmail,
        "message": "Enjoy your gift card! Cheers...",
        "scheduledFor": _getDate() + "T" + _getTime() + ".000Z",
      }
    });
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlYmY0ZGExNC01NGJiLTQ1MTctYjRiZC04YzNhZjYyMzRhYmQiLCJzdWIiOiJhbGlhc2FkNjUyMUBnbWFpbC5jb20iLCJleHAiOjE5MjA0MzcwNzIsImlzcyI6Imh0dHBzOi8vZ2lmdHVwLmFwcC8iLCJhdWQiOiJodHRwczovL2dpZnR1cC5hcHAvIn0.N-17aBufwWK5biyuqskuOqxUhKj6GwJdUwI08_A1F34";
    http.Response response = await http.post(
      "https://api.giftup.app/orders/",
      headers: {
        'Authorization': "Bearer $token",
        'Accepts': 'application/json',
        'x-giftup-testmode': 'true',
        'Content-Type': 'application/json',
      },
      body: msg,
    );

    if (response.statusCode == 201) {
      var dataDecoded = jsonDecode(response.body);
      setState(() {
        imageUrl = dataDecoded["giftCards"][0]['downloadLinks']['imageUrl'];
        senderEmail = senEmail;
        receiverEmail = recEmail;
      });

      databaseReference.collection("rewards").add({
        'imageUrl': imageUrl,
        'senderEmail': senEmail,
        "receiverEmail": recEmail,
        'receiverName': receiverName,
        'senderName': senderName,
      });
    } else {
      print(jsonDecode(response.body));
      print("hi");
      throw Exception('Failed to load gift card');
    }
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItemsCategory(
      List companies) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              company.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<CustomUser>> buildDropdownMenuItemsEmployee(employees) {
    List<DropdownMenuItem<CustomUser>> items = [];
    for (CustomUser employee in employees) {
      items.add(
        DropdownMenuItem(
          value: employee,
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 18,
                backgroundImage: employee.imgUrl != null
                    ? NetworkImage(employee.imgUrl)
                    : AssetImage('assets/images/profile.jpg'),
              ),
              title: Text(
                employee.name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    fontSize: 13),
              ),
              subtitle: Text(employee.email),
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemCategory(Category selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  onChangeDropdownItemEmployee(CustomUser selectedEmployee) {
    setState(() {
      _selectedEmployee = selectedEmployee;
    });
  }

  Widget _buildScreenUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14, top: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading("Cheers For Your Peer!"),
            SizedBox(
              height: 5,
            ),
            this.widget.teamList != null
                ? _buildDropDownEmployee()
                : Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: this.widget.employee.imgUrl != null
                              ? NetworkImage(this.widget.employee.imgUrl)
                              : AssetImage('assets/images/profile.jpg'),
                        ),
                        title: Text(
                          this.widget.employee.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                              fontSize: 13),
                        ),
                        subtitle: Text(this.widget.employee.email),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Title',
                          contentPadding: EdgeInsets.only(left: 16),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    _buildTextField(this.textFieldColor),
                  ],
                ),
              ),
            ),
            _buildSubHeading('Select Desired Color'),
            Row(
              children: [
                _buildColoredContainer(Colors.blue, _isBlueChecked),
                _buildColoredContainer(Colors.teal, _isTealChecked),
                _buildColoredContainer(Colors.redAccent, _isRedChecked),
                _buildColoredContainer(Colors.orange, _isOrangeChecked),
                _buildColoredContainer(Colors.purple, _isPurpleChecked)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _buildSubHeading("Select the Label"),
            _buildContainer(),
            cheerType == 1
                ? _buildSubHeading('Select a Category')
                : Container(),
            cheerType == 1 ? _buildDropDownCategory() : Container(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  _buildSubHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  _buildTextField(fillColor) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return ("Field cannot be empty");
        }
        return null;
      },
      controller: _messageTextController,
      maxLines: 4,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor.withOpacity(0.32),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: fillColor, width: 0),
        ),
        hintText: 'Type a Super Nice Message...',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: fillColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  _buildContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                this.cheerType = 1;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Cheers",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  border: Border.all(
                      color: Colors.green,
                      style: cheerType == 1
                          ? BorderStyle.solid
                          : BorderStyle.none),
                  color: Colors.green.withOpacity(0.32),
                )),
          ),
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                this.cheerType = 2;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Birthday",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.red,
                      style: cheerType == 2
                          ? BorderStyle.solid
                          : BorderStyle.none),
                  color: Colors.red.withOpacity(0.32),
                )),
          ),
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                this.cheerType = 3;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Kudos",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Theme.of(context).primaryColor.withOpacity(0.32),
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      style: cheerType == 3
                          ? BorderStyle.solid
                          : BorderStyle.none),
                )),
          ),
        ],
      ),
    );
  }

  _buildColoredContainer(Color color, bool visibility) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            if (color == Colors.redAccent) {
              _isRedChecked = true;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.redAccent;
            } else if (color == Colors.blue) {
              _isRedChecked = false;
              _isBlueChecked = true;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.blue;
            } else if (color == Colors.teal) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = true;
              this.textFieldColor = Colors.teal;
            } else if (color == Colors.orange) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = true;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.orange;
            } else if (color == Colors.purple) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = true;
              _isTealChecked = false;
              this.textFieldColor = Colors.purple;
            }
          });
        },
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(
                color: color.withOpacity(0.32),
                width: 2,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(40),
            color: color.withOpacity(0.35),
          ),
          child: Visibility(
            visible: visibility,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildDropDownCategory() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: _selectedCompany,
          items: _dropdownMenuItemsCategory,
          onChanged: onChangeDropdownItemCategory,
        ),
      ),
    );
  }

  _buildDropDownEmployee() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          itemHeight: 60,
          value: _selectedEmployee,
          items: _dropdownMenuItemsEmployee,
          onChanged: onChangeDropdownItemEmployee,
        ),
      ),
    );
  }

  _buildButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: FlatButton(
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            showAlertDialog(context);
            SharedPreferences prefs = await _prefs;
            var color;
            if (this.textFieldColor == Colors.blue) {
              color = 1;
            } else if (this.textFieldColor == Colors.teal) {
              color = 2;
            } else if (this.textFieldColor == Colors.redAccent) {
              color = 3;
            } else if (this.textFieldColor == Colors.orange) {
              color = 4;
            } else if (this.textFieldColor == Colors.purple) {
              color = 5;
            } else {
              color = 1;
            }
            var recvEmail = this.widget.employee != null
                ? this.widget.employee.email
                : this._selectedEmployee.email;
            var pointsToAdd = 0;
            if (cheerType == 1) {
              //Cheeer
              pointsToAdd += 5;
            } else if (cheerType == 2) {
              //Bday
              pointsToAdd += 2;
            } else if (cheerType == 3) {
              //Kudos
              pointsToAdd += 10;
              //target_points = current_level *50

            }

            var userRef = databaseReference.collection('users');
            await userRef.where('email', isEqualTo: recvEmail).get().then(
                  (value) => value.docs.forEach((element) {
                    var userOldData = CustomUser.fromJson(element.data());
                    var newPoints = userOldData.points + pointsToAdd;
                    var _currentLevel = userOldData.level;
                    var targetPoints = _currentLevel * 50;
                    if (userOldData.points < targetPoints &&
                        newPoints >= targetPoints) {
                      _currentLevel += 1;
                      fetchGiftUp(
                          prefs.getString('name'),
                          this.widget.employee != null
                              ? this.widget.employee.name
                              : this._selectedEmployee.name,
                          prefs.getString('email'),
                          this.widget.employee != null
                              ? this.widget.employee.email
                              : this._selectedEmployee.email);
                    }

                    userRef.doc(element.id).update({
                      'points': userOldData.points + pointsToAdd,
                      'level': _currentLevel,
                      'category1': _selectedCompany.id == 1
                          ? userOldData.category1 += 2
                          : userOldData.category1,
                      'category2': _selectedCompany.id == 2
                          ? userOldData.category2 += 2
                          : userOldData.category2,
                      'category3': _selectedCompany.id == 3
                          ? userOldData.category3 += 2
                          : userOldData.category3,
                      'category4': _selectedCompany.id == 4
                          ? userOldData.category4 += 2
                          : userOldData.category4,
                      'category5': _selectedCompany.id == 5
                          ? userOldData.category5 += 2
                          : userOldData.category5
                    });
                  }),
                );
            Cheer cheer = Cheer.name(
              _titleController.text,
              prefs.getString('email'),
              prefs.getString('name'),
              prefs.getString('imgUrl'),
              this.widget.employee != null
                  ? this.widget.employee.name
                  : this._selectedEmployee.name,
              prefs.getString('role'),
              this.widget.employee != null
                  ? this.widget.employee.email
                  : this._selectedEmployee.email,
              _messageTextController.text,
              color,
              cheerType,
              _selectedCompany.name,
              DateTime.now(),
                prefs.getString('companyName')
            );
            CustomNotificationData notification = CustomNotificationData.name(
              prefs.getString('companyName'),
              true,
              _titleController.text,
              prefs.getString('email'),
              prefs.getString('name'),
              prefs.getString('imgUrl'),
              this.widget.employee != null
                  ? this.widget.employee.name
                  : this._selectedEmployee.name,
              prefs.getString('role'),
              this.widget.employee != null
                  ? this.widget.employee.email
                  : this._selectedEmployee.email,
              _messageTextController.text,
              DateTime.now(),
            );
            await databaseReference.collection("cheers").add(cheer.toJson());
            await databaseReference
                .collection("notifications")
                .add(notification.toJson());
            String notifTitle = '';
            if (cheerType == 1) {
              notifTitle = 'Cheers';
            } else if (cheerType == 2) {
              notifTitle = 'Birthday Wish';
            } else {
              notifTitle = 'Kudos';
            }
            sendNotification(
                this.widget.employee != null
                    ? this.widget.employee.fcmToken
                    : this._selectedEmployee.fcmToken,
                prefs.getString('name'),
                this.widget.employee != null
                    ? this.widget.employee.name
                    : this._selectedEmployee.name,
                notifTitle);


            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: Container(
          width: 140,
          height: 39,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Send with Love",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.favorite,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _buildScreenUI(context),
        ],
      )),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "Sending...",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  sendNotification(
      String registrationToken, senderName, receiverName, title) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String fcmToken = await firebaseMessaging.getToken();
    print(fcmToken);
    final String serverToken =
        'AAAAPBqZUsQ:APA91bEyq7Cw0PFXG96ruMJpw3hUa18z96TVs8GRKX3ZsgTsalXfLP0U2JW41Z5byOCym_wSqDMydEqmaY_uuVys2jMUJIH0Va7LtvYmtUBu0eHmIA4RONRCsLuc7xsC7xlp8I4rtJeV';

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '${_messageTextController.text}',
            'title': '$title Received from $senderName'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': registrationToken,
        },
      ),
    );
    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        completer.complete(message);
      },
    );

    return completer.future;
  }
}

class Category {
  int id;
  String name;

  Category(this.id, this.name);

  static List<Category> getCategory() {
    return <Category>[
      Category(4, 'Friendliness'),
      Category(1, 'Hardwork'),
      Category(2, 'Dedication'),
      Category(3, 'Teamwork'),
      Category(5, 'Productivity'),
    ];
  }
}
