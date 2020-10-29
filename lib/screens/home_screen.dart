import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
import 'package:Invicta/widgets/home_feed_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen(this.name);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    var name = this.widget.name.split(' ');
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CustomSliverAppBar(title: 'Good Day, ${name[0]}',height: 220,),
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


