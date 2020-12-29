import 'package:Invicta/screens/create_cheer_screen.dart';
import 'package:Invicta/screens/rewards_screen.dart';
import 'package:Invicta/screens/welcome.dart';
import 'package:Invicta/widgets/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  final isMyProfile;
  final user;

  ProfileScreen(this.isMyProfile, this.user);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var initialFriendlinessWidth = 0.0;
  var initialTeamworkWidth = 0.0;
  var initialDedicationWidth = 0.0;
  var initialHardworkWidth = 0.0;
  var initialProductivityWidth = 0.0;
  String _appBadgeSupported = "nothing";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override

  void initState() {
    super

        .initState();
    initPlatformState();
    //Method Called on build complete
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => updateWidth(context));
  }
  void _removeBadge() {

      FlutterAppBadger.removeBadge();



  }
  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: 400,
                color: Theme.of(context).primaryColor,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: this.widget.isMyProfile
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => RewardsScreen(
                                                this.widget.user.email)));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _removeBadge();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => NotificationScreen(
                                                this.widget.user.email)));
                                  },
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: FlatButton(
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                          fontFamily: 'OpenSans'),
                                    ),
                                    onPressed: () async {
                                      FirebaseAuth.instance.signOut();
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      prefs.clear();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (_) => WelcomePage()),
                                          (route) => false);
                                    },
                                  ),
                                )
                              ],
                            )
                          : Container(
                              height: 25,
                              margin: EdgeInsets.only(right: 16, top: 16),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => CreateCheerScreen(
                                          employee: this.widget.user)));
                                },
                                child: Text(
                                  'Give Cheer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      fontFamily: 'OpenSans'),
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 64),
                      child: Container(
                        width: screenWidth - 32,
                        height: 308,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Hero(
                              tag: 'profile',
                              child: ProfileImage(
                                imageData:
                                    NetworkImage(this.widget.user.imgUrl),
                                imgDiameter: 72.0,
                                borderDiameter: 80.0,
                              ),
                            ),
                            Text(
                              '${this.widget.user.name}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            Text(
                              '${this.widget.user.role}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8F8F8F),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  this.widget.user.level >= 50
                                      ? createBadge(
                                          Colors.orange, Colors.yellow, 'Gold')
                                      : this.widget.user.level >= 25
                                          ? createBadge(
                                              Colors.blueGrey,
                                              Colors.grey.withOpacity(0.32),
                                              'Silver')
                                          : this.widget.user.level >= 10
                                              ? createBadge(
                                                  Colors.brown,
                                                  Colors.brown
                                                      .withOpacity(0.32),
                                                  'Bronze')
                                              : Container(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 56,
                                          width: 56,
                                          margin: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.32),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.leaderboard,
                                            size: 40,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        Text(
                                          'LVL \u2022 ${this.widget.user.level.toString()}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'OpenSans',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 56,
                                          width: 56,
                                          margin: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.green
                                                  .withOpacity(0.32),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.star,
                                            size: 40,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text(
                                          '${this.widget.user.points.toString()} Points',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'OpenSans',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 400),
                  child: Container(
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getLabelName('Statistics'),
                        getProgressBar('Friendliness', initialFriendlinessWidth,
                            Theme.of(context).primaryColor, context, 1),
                        getProgressBar('Hardwork', initialHardworkWidth,
                            Colors.green, context, 2),
                        getProgressBar('Dedication', initialDedicationWidth,
                            Colors.yellow, context, 3),
                        getProgressBar('Team Work', initialTeamworkWidth,
                            Colors.deepPurpleAccent, context, 4),
                        getProgressBar('Productivity', initialProductivityWidth,
                            Colors.red, context, 5),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding createBadge(darkColor, lightColor, text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            margin: EdgeInsets.only(bottom: 8),
            decoration:
                BoxDecoration(color: lightColor, shape: BoxShape.circle),
            child: Icon(
              Icons.auto_awesome,
              size: 40,
              color: darkColor,
            ),
          ),
          Text(
            '$text Badge',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
            ),
          )
        ],
      ),
    );
  }

  Widget getProgressBar(labelName, value, color, context, duration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCategoryName('$labelName'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.32),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  AnimatedContainer(
                    height: 36,
                    width: (MediaQuery.of(context).size.width - 32) * value,
                    duration: Duration(seconds: duration),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              // getLabelName('${(value * 100).round()}%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCategoryName(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16.0, bottom: 8.0),
      child: Text(
        '$label',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  Widget getLabelName(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16.0, bottom: 8.0),
      child: Text(
        '$label',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  updateWidth(BuildContext context) {
    setState(() {
      var total = this.widget.user.category1 +
          this.widget.user.category2 +
          this.widget.user.category3 +
          this.widget.user.category4 +
          this.widget.user.category5;
      if (total == 0) {
        total = 1;
      }
      initialFriendlinessWidth = this.widget.user.category1 / total;
      initialTeamworkWidth = this.widget.user.category2 / total;
      initialDedicationWidth = this.widget.user.category3 / total;
      initialHardworkWidth = this.widget.user.category4 / total;
      initialProductivityWidth = this.widget.user.category5 / total;
    });
  }
}
