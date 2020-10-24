import 'package:Invicta/widgets/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var initialFriendlinessWidth = 0.05;
  var initialTeamworkWidth = 0.05;
  var initialDedicationWidth = 0.05;
  var initialHardworkWidth = 0.05;
  var initialProductivityWidth = 0.05;

  @override
  void initState() {
    super.initState();
    //Method Called on build complete
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => updateWidth(context));
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
                            ProfileImage(
                              profileImgUrl: 'assets/images/profile.jpg',
                              imgDiameter: 72.0,
                              borderDiameter: 80.0,
                            ),
                            Text(
                              'Awais Qamar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            Text(
                              'Senior React Developer',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8F8F8F),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            Text(
                              '1200 Points',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 56,
                                        width: 56,
                                        margin: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.auto_awesome,
                                          size: 40,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Text(
                                        'Gold Badge',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'OpenSans',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
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
                                        'LVL 10',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'OpenSans',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 56,
                                        width: 56,
                                        margin: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.32),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.star,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        '100 Points',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'OpenSans',
                                        ),
                                      )
                                    ],
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
                        getLabelName('Summary'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.deepPurple.withOpacity(0.32),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.leaderboard,
                                      size: 20,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  Text(
                                    'Level',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'OpenSans',
                                      color: Colors.deepPurple,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Color(0xFFD3D9E8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFF2E68FF).withOpacity(0.32),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.leaderboard,
                                      size: 20,
                                      color: Color(0xFF2E68FF),
                                    ),
                                  ),
                                  Text(
                                    'Points',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  Text(
                                    '1020',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'OpenSans',
                                      color: Color(0xFF2E68FF),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.32),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.leaderboard,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Text(
                                    'Badge',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  Text(
                                    'Gold',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'OpenSans',
                                        color: Colors.orange),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        getLabelName('Your Stats'),
                        getProgressBar('Friendliness', initialFriendlinessWidth,
                            Theme.of(context).primaryColor, context),
                        getProgressBar('Hardwork', initialHardworkWidth,
                            Colors.green, context),
                        getProgressBar('Dedication', initialDedicationWidth,
                            Colors.yellow, context),
                        getProgressBar('Team Work', initialTeamworkWidth,
                            Colors.deepPurpleAccent, context),
                        getProgressBar('Productivity', initialProductivityWidth,
                            Colors.red, context),
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

  Widget getProgressBar(labelName, value, color, context) {
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
                    width: MediaQuery.of(context).size.width - 102,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.32),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  AnimatedContainer(
                    height: 36,
                    width: (MediaQuery.of(context).size.width - 100) * value,
                    duration: Duration(seconds: 5),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              getLabelName('${(value * 100).round()}%'),
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
      padding: const EdgeInsets.only(top: 8, left: 16.0, bottom: 8.0),
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
      initialFriendlinessWidth = 0.85;
      initialTeamworkWidth = 0.65;
      initialDedicationWidth = 0.35;
      initialHardworkWidth = 0.95;
      initialProductivityWidth = 0.15;
    });
  }
}
