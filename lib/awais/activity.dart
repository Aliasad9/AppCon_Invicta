import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/home_feed_card.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List _buildListItems(length) {
    List<Widget> listItems = [];
    for (var i = 0; i < length; i++) listItems.add(HomeFeedCard());
    return listItems;
  }
  Widget _buildActivity(){
    return  Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1CAFF),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 180,
        height: 30,
        child: Center(
          child: Text(
//change the color contrast here
            "Showing all Employees Activity",
            style: TextStyle(
              fontWeight: FontWeight.bold,

                color:  Colors.pink,

                fontSize: 11
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),


            child: Wrap(
              children: [
                _buildActivity(),


                Container(
                  margin: const EdgeInsets.only(top:30,left:10.0,),
                  child: Text("Cheers",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF575757),
                    fontSize: 18,
                  ),),
                ),
      //error throwing widget
      CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [

          SliverList(
            delegate: new SliverChildListDelegate(_buildListItems(10)),
          )
        ],
      )

              ],
            )

    );
  }
}
