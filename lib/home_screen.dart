import 'package:Invicta/widgets/home_feed_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'John';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          expandedHeight: 308,
          collapsedHeight: 80,
          automaticallyImplyLeading: false,
          centerTitle: false,
          primary: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Padding(
              padding: const EdgeInsets.only(top: 80, left: 16.0),
              child: Text(
                'Good Morning, ${name}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Arvo',
                  fontWeight: FontWeight.w700,
                  fontSize: 45,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: new SliverChildListDelegate(_buildListItems(10)),
        )
      ],
    );
  }

  List _buildListItems(length) {
    List<Widget> listItems = [];
    for (var i = 0; i < length; i++) listItems.add(HomeFeedCard());
    return listItems;
  }
}
