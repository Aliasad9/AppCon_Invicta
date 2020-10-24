import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
import 'package:Invicta/widgets/team_member_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamMembers extends StatefulWidget {
  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  var leaderboardItems = [
    {
      'name': 'Awais Qamar',
      'position': '1st',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Backend Developer',
      'company': 'Facebook',
      'level': '10'
    },
    {
      'name': 'Adam Lee',
      'position': '2nd',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Backend Developer',
      'company': 'Traverse',
      'level': '10'
    },
    {
      'name': 'Jones Stuart',
      'position': '3rd',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Backend Developer',
      'company': 'Google',
      'level': '10'
    },
    {
      'name': 'Chris Eduardo',
      'position': '4th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Frontend Developer',
      'company': 'Traverse',
      'level': '10'
    },
    {
      'name': 'Tom Brown',
      'position': '5th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'UI/UX Designer',
      'company': 'Youtube',
      'level': '11'
    },
    {
      'name': 'Chris Eduardo',
      'position': '4th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Frontend Developer',
      'company': 'Traverse',
      'level': '10'
    },
    {
      'name': 'Tom Brown',
      'position': '5th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'UI/UX Designer',
      'company': 'Youtube',
      'level': '11'
    },
    {
      'name': 'Chris Eduardo',
      'position': '4th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Frontend Developer',
      'company': 'Traverse',
      'level': '10'
    },
    {
      'name': 'Tom Brown',
      'position': '5th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'UI/UX Designer',
      'company': 'Youtube',
      'level': '11'
    },
    {
      'name': 'Chris Eduardo',
      'position': '4th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'Frontend Developer',
      'company': 'Traverse',
      'level': '10'
    },
    {
      'name': 'Tom Brown',
      'position': '5th',
      'imgUrl': 'assets/images/profile.jpg',
      'role': 'UI/UX Designer',
      'company': 'Youtube',
      'level': '11'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CustomSliverAppBar(title: 'Your Amazing Team',height: 285,),
        SliverList(
          delegate: new SliverChildListDelegate(_buildListItems(10)),
        )
      ],
    );
  }

  List _buildListItems(length) {
    List<Widget> listItems = [];
    for (var index = 0; index < this.leaderboardItems.length; index++)
      listItems.add(TeamMemberCard(
          name: leaderboardItems[index]['name'],
          imgUrl: leaderboardItems[index]['imgUrl'],
          role: leaderboardItems[index]['role'],
          company: leaderboardItems[index]['company'],
          level: leaderboardItems[index]['level']));
    return listItems;
  }
}
