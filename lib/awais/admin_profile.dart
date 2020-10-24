import 'package:Invicta/widgets/profile_image.dart';
import 'package:Invicta/widgets/teams_grid_admin.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile>
    with TickerProviderStateMixin {
  TabController _tabController;

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
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: ProfileImage(
                      borderDiameter: 84.0,
                      imgDiameter: 78,
                      profileImgUrl: 'assets/images/profile.jpg',
                    ),
                  ),
                  Text(
                    "Awais Qamar",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "System Admin",
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
              padding: const EdgeInsets.only(top:250.0),
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
                  height:screenWidth-320,

                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TeamGridAdmin(),
                      // Container(
                      //   child: Text("yo boy"),
                      // ),
                      Container(
                        child: Text("yo boy"),
                      )
                    ],
                  ),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
