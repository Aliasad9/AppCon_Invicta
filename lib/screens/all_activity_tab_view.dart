import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/home_feed_card.dart';

class AllActivity extends StatefulWidget {
  @override
  _AllActivityState createState() => _AllActivityState();
}

class _AllActivityState extends State<AllActivity> {
  List _buildListItems(length) {
    List<Widget> listItems = [];
    for (var i = 0; i < length; i++) listItems.add(HomeFeedCard());
    return listItems;
  }

  Widget _buildActivity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.32),
            borderRadius: BorderRadius.circular(24),
          ),
          width: 220,
          height: 24,
          child: Center(
            child: Text(
              "Showing all Employees Activity",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _buildActivity(),
        ),
        SliverList(
          delegate: new SliverChildListDelegate(_buildListItems(10)),
        )
      ],
    );
  }
}
