import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 2, vsync:this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Invicta',
            style: TextStyle(color: Colors.black),
          ),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(4),
                color: Colors.redAccent,
              ),
              child: RaisedButton(
                onPressed: null,
                child: Center(child: Text("Logout",style: TextStyle(
                  color:
                    Colors.white,
                ),),

                ),


              ),
            )
          ],
        ),
        body:Column(
          children: [
            Container(
              child: Align(

                alignment: Alignment.topCenter,
                child: Container(

                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(left: 50, right: 50,top: 40),
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 35,
                    backgroundImage: ExactAssetImage('images/a.jpg'),
                  ),
                  decoration: new BoxDecoration(

                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.blueAccent,
                      width: 4.0,
                    ),
                  ),

                ),


              ),



            ),
            Padding(padding:EdgeInsets.symmetric(vertical: 6)),
            Text("Awais Qamar",style: TextStyle(

              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),
            Text("System Admin",style: TextStyle(color: Colors.black45),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Container(child:
            Column(
              children: <Widget>[
              Container(
              height: 60,
              margin: EdgeInsets.only(left: 20),
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
                indicatorPadding: EdgeInsets.all(10),
                isScrollable: false,
                controller: _tabController,
              ),
            ),
                Container(
                  height: 100,
                  child: TabBarView(
                      controller: _tabController,


                              ),
                            ),


                        Container(
                          child: Text("..."),
                        )
                      ]),
                )
            ]
            ),


        ) ,
    );
  }
}
