import 'package:Invicta/data/user.dart';
import 'package:Invicta/screens/create_cheer_screen.dart';
import 'package:Invicta/screens/home_screen.dart';
import 'package:Invicta/screens/leaderboard_screen.dart';
import 'package:Invicta/screens/team_members.dart';
import 'package:Invicta/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../icons/my_flutter_app_icons.dart';

class NavigationScreen extends StatefulWidget {
  final String imgUrl;
  final String companyName;
  final String name;
  final String email;
  final CustomUser user;

  NavigationScreen(
      this.imgUrl, this.companyName, this.name, this.email, this.user);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final databaseReference = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();


  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('DISMISS'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

      },
      onBackgroundMessage: myBackgroundMessageHandler//Platform.isIOS ? null :myBackgroundMessageHandler
    );
  }


  @override
  Widget build(BuildContext context) {
    var navigationPages = [
      HomeScreen(this.widget.name, this.widget.email),
      TeamMembers(this.widget.companyName, this.widget.email),
      LeaderboardScreen()
    ];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: navigationPages,
            ),
            _currentIndex != 2
                ? CustomAppBar(
                    this.widget.imgUrl != null
                        ? NetworkImage(this.widget.imgUrl)
                        : AssetImage('assets/images/profile.jpg'),
                    this.widget.user)
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 20,
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.transparent,
            height: 60,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                            iconSize: 30.0,
                            icon: Icon(MyFlutterApp.home_outline,
                                color: Colors.black),
                          ),
                          _currentIndex == 0
                              ? Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  height: 6,
                                  width: 6,
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            iconSize: 30.0,
                            icon: Icon(MyFlutterApp.users_outline,
                                color: Colors.black),
                          ),
                          _currentIndex == 1
                              ? Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  height: 6,
                                  width: 6,
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                            iconSize: 30.0,
                            icon: Icon(MyFlutterApp.graduation_hat,
                                color: Colors.black),
                          ),
                          _currentIndex == 2
                              ? Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  height: 6,
                                  width: 6,
                                ),
                        ],
                      ),
                      SizedBox(
                        width: 64,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            List<CustomUser> list = [];
            await databaseReference
                .collection("users")
                .where("companyName", isEqualTo: this.widget.companyName)
                .get()
                .then(
                  (QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
                    CustomUser user = CustomUser.fromJson(element.data());
                    if (user.email != this.widget.email) {
                      list.add(user);
                    }
                  }),
                );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateCheerScreen(teamList: list),
              ),
            );
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent.withOpacity(0.7), Colors.red],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.32),
                      blurRadius: 6)
                ]),
            child: Center(
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  debugPrint('On background message $message');
  return Future<void>.value();
}