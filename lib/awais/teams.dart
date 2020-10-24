import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/name_number.dart';
import '../widgets/heading.dart';

class Teams extends StatefulWidget {

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {




  Widget _buildCard(
      String title,
      IconData icon,
      String subTitle,
      String members,
      String cardText,
      String bottomText,
      Color color1,
      Color color2) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color2),
          borderRadius: BorderRadius.circular(5),
          color: color1,
        ),
        //  height: 200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .merge(TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: color2,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(subTitle), Text(members)],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Card(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cardText),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                bottomText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .merge(TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(

            body: Stack(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:300.0),
                  child: ListView.builder(itemCount:5,itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _buildCard(
                            "Alfa Bolt",
                            Icons.star_border,
                            "Web Development for X.Y.Z Company",
                            "5 Members",
                            "Front End Web Developer",
                            "View  Team Members",
                            Colors.blue.withOpacity(0.35),
                            Colors.blue.withOpacity(1)),
                     _buildCard(
                       "Traverse",
                        Icons.ac_unit,
                        "Dev Ops for X.Y.Z Company",
                        "7 Members",
                        "Product Manager",
                        "View  Team Members",
                        Colors.purple.withOpacity(0.35),
                        Colors.purple.withOpacity(1),
                     )
                      ],
                    );

                  }),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6, right: 7, left: 5),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 30,
                            ),
                          ),
                          Text(
                            "Cheers Everyone",
                            style: TextStyle(
                              fontFamily: "Oswald",
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.only(left: 140, right: 10),
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
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
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Heading("Show 'em some Love!"),
                      SizedBox(
                        height: 10,
                      ),
                      NameNumber("Your teams","2"),

                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.home,
                    size: 24,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.supervised_user_circle,
                    size: 24,
                  ),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.emoji_events,
                    size: 24,
                  ),
                  label: "Achievements",
                ),
              ],
            ),
            floatingActionButton: new FloatingActionButton(
                elevation: 0.0,
                child: new Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 36,
                ),
                backgroundColor: Colors.pink,
                onPressed: () {
                  Navigator.pushNamed(context, '/team_members');
                })),
      ),
    );
  }
}
