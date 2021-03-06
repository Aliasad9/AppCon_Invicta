import 'package:Invicta/data/user.dart';
import 'package:Invicta/widgets/leaderboard_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  ScrollController _scrollController;
  double kExpandedHeight = 250;
  bool _showTitle = false;

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: CustomScrollView(
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
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .orderBy('points', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data.size > 0) {
                                var fetchedDataJson =
                                    snapshot.data.docs[0].data();
                                CustomUser user =
                                    CustomUser.fromJson(fetchedDataJson);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Leaderboard',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFFFD700), width: 4),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: 72.0,
                                            height: 72.0,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(user.imgUrl),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Text(
                                      '${user.name}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                    Text(
                                      '${user.role}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF8F8F8F),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                    Text(
                                      '${user.points} Points',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SliverToBoxAdapter(
                                  child: Text('No User Exists'),
                                );
                              }
                            }),
                      ),
                    ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .orderBy('points', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              var count=0;
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Text(
                    'No Team Members Found :(',
                  ),
                );
              } else if (snapshot.hasData) {
                return (snapshot.hasData && snapshot.data.size > 0)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var fetchedJsonData =
                                snapshot.data.docs[index].data();

                            // if (fetchedJsonData['email'] != this.widget.email) {
                            CustomUser user =
                                CustomUser.fromJson(fetchedJsonData);
                            if (user.companyName != null) {
                              count+=1;
                              return LeaderboardCard(
                                  user: user, position: (count).toString());
                            } else {
                              return Container();
                            }
                          },
                          childCount: snapshot.data.size,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          child: Center(
                            child: Text(
                              'No Team Members Found :(',
                            ),
                          ),
                        ),
                      );
              } else {
                return SliverToBoxAdapter(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
