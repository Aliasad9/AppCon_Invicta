import 'package:Invicta/widgets/leaderboard_card.dart';
import 'package:Invicta/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  ScrollController _scrollController;
  double kExpandedHeight = 250;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        final isNotExpanded = _scrollController.hasClients &&
            _scrollController.offset > kExpandedHeight - kToolbarHeight;
        if (isNotExpanded != _showTitle) {
          setState(() {
            _showTitle = isNotExpanded;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: kExpandedHeight,
          automaticallyImplyLeading: false,
          centerTitle: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 16, bottom: 16),
            centerTitle: false,
            title: _showTitle
                ? Text(
                    'Rankings',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  )
                : null,
            background: _showTitle
                ? null
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Leaderboard',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          ProfileImage(
                            profileImgUrl: 'assets/images/profile.jpg',
                            imgDiameter: 72.0,
                            borderDiameter: 80.0,
                          ),
                          Text(
                            'Awais Qamar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Text(
                            'Senior React Developer',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8F8F8F),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Text(
                            '1200 Points',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        SliverList(
          delegate: new SliverChildListDelegate(_buildListItems()),
        )
      ],
    );
  }

  List _buildListItems() {
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
    List<Widget> listItems = [];
    for (var i = 0; i < leaderboardItems.length; i++)
      listItems.add(
        LeaderboardCard(
          name: leaderboardItems[i]['name'],
            position: leaderboardItems[i]['position'],
            imgUrl:leaderboardItems[i]['imgUrl'],
            role: leaderboardItems[i]['role'],
            company: leaderboardItems[i]['company'],
            level: leaderboardItems[i]['level']
        ),
      );
    return listItems;
  }
}
