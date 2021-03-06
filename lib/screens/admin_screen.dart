import 'package:Invicta/screens/all_activity_tab_view.dart';
import 'package:Invicta/screens/create_new_team.dart';
import 'package:Invicta/screens/welcome.dart';
import 'package:Invicta/widgets/profile_image.dart';
import 'package:Invicta/widgets/teams_grid_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfile extends StatefulWidget {
  final user;

  AdminProfile(this.user);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile>
    with TickerProviderStateMixin {
  TabController _tabController;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 8,
                      ),
                      child: Image.asset('assets/images/logo.png',width: 40, height: 40,),
                    ),
                    Text(
                      "Invicta",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:16.0, top:24),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 76,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF3535),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45.withOpacity(0.4),
                            blurRadius: 2,
                            offset: Offset(0, 2))
                      ]),
                  child: Center(
                    child: FlatButton(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans',
                          fontSize: 11,
                        ),
                      ),
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        final SharedPreferences prefs = await _prefs;
                        prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => WelcomePage()),
                            (route) => false);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ProfileImage(
                      borderDiameter: 84.0,
                      imgDiameter: 78,
                      imageData: NetworkImage('${this.widget.user.imgUrl}'),
                    ),
                  ),
                  Text(
                    "${this.widget.user.name}",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${this.widget.user.role}",
                    style: TextStyle(
                      color: Colors.black45,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Column(children: <Widget>[
                Container(
                  child: TabBar(
                    tabs: [
                      Container(
                        // width: 60.0,
                        child: new Text(
                          'Teams',
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                      Container(
                        // width: 60.0,
                        child: new Text(
                          'All Activity',
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(8),
                      )
                    ],
                    unselectedLabelColor: const Color(0xffacb3bf),
                    indicatorColor: Colors.blue,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.0,
                    isScrollable: false,
                    controller: _tabController,
                  ),
                ),
                Container(
                  height: screenWidth - 320,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TeamGridAdmin(),
                      AllActivity(),
                    ],
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.redAccent.withOpacity(0.7),
                            Colors.red
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.32),
                              blurRadius: 6)
                        ]),
                    child: Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CreateNewTeam()));
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
