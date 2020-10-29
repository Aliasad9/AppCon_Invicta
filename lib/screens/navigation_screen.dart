import 'dart:io';
import 'package:Invicta/screens/create_cheer_screen.dart';
import 'package:Invicta/screens/home_screen.dart';
import 'package:Invicta/screens/leaderboard_screen.dart';
import 'package:Invicta/screens/team_members.dart';
import 'package:Invicta/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../icons/my_flutter_app_icons.dart';

class NavigationScreen extends StatefulWidget {
  final String imgUrl;
  final String companyName;


  NavigationScreen(this.imgUrl, this.companyName);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    var navigationPages = [HomeScreen(), TeamMembers(this.widget.companyName), LeaderboardScreen()];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: navigationPages,
            ),
            _currentIndex != 2
                ? CustomAppBar(FileImage(File(this.widget.imgUrl)))
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
                            icon: Icon(MyFlutterApp.home_2, color: Colors.black),
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
                            icon: Icon(MyFlutterApp.heart_empty, color: Colors.black),
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
                            icon: Icon(MyFlutterApp.trophy, color: Colors.black),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateCheerScreen(),
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
            child: Icon(
              CupertinoIcons.heart,
              color: Colors.white,
              size: 40,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
