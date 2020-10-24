import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
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
        CustomSliverAppBar(title: 'Good Day, John'),
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


