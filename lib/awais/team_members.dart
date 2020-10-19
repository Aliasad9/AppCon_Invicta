import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiauth/heading.dart';
import 'name_number.dart';

class TeamMembers extends StatefulWidget {
  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {

  Widget _buildProfileList(String image,
      String name,
      String designation,
      String company,
      int level,
      Color color,) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(image),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
          child: Row(
            children: [
              Text(designation),
              SizedBox(
                width: 1,
              ),
              Container(
                  child: Center(
                    child: Text(
                      company,
                      style: TextStyle(
                        fontFamily: "Oswald",
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  width: 80,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color,
                  )),
            ],
          ),
        ),
        trailing: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Flexible(
                child: Text(
                  "LVL" + level.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),


             InkWell(
               onTap: (){
                 Navigator.pushNamed(context, '/chat_screen');
               },
               child: Container(
                 child: Flexible(
                       child: Text(
                      "View Profile",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
               ),
             ),

          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Invicta',
                style: TextStyle(color: Colors.black),
              ),
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
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
                )
              ],
            ),
            body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Heading("Select the choosen one!"),
                  NameNumber("Recently Contacted", "2"),
                  Container(
                    height:200 ,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return
                            _buildProfileList(
                                "images/a.jpg",
                                "Ali Asad",
                                "Frontend Developer at",
                                "AlphaBolt",
                                100,
                                Colors.blue.withOpacity(0.35));

                      },
                    ),
                  ),
                  NameNumber("Your Team Members", "22"),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return
                            _buildProfileList(
                                "images/a.jpg",
                                "Ali Asad",
                                "Frontend Developer at",
                                "AlphaBolt",
                                100,
                                Colors.blue.withOpacity(0.35));

                      },
                    ),
                  ),
                ]
            )
        )
    );
  }

}