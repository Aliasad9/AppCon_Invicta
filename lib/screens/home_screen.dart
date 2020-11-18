import 'package:Invicta/data/cheer.dart';
import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
import 'package:Invicta/widgets/home_feed_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String companyName;

  HomeScreen(this.name, this.companyName);

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
        CustomSliverAppBar(
          title: 'Good Day, ${name[0]}',
          height: 220,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("cheers")
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              var count = 0;
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData) {
                return (snapshot.hasData && snapshot.data.size > 0)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var fetchedJsonData =
                                snapshot.data.docs[index].data();
                            Cheer cheer = Cheer.fromJson(fetchedJsonData);
                            if (cheer.companyName == this.widget.companyName ) {
                              var timeAgo = Cheer.createdAtToDifference(cheer.createdAt);
                              count++;

                              return HomeFeedCard(
                                  NetworkImage(cheer.senderImgData),
                                  cheer.senderName,
                                  cheer.receiverName,
                                  timeAgo,
                                  cheer.senderRole,
                                  cheer.title,
                                  cheer.cheerMsg,
                                  cheer.color,
                                  cheer.label);
                            } else {
                              if (count == 0) {
                                count++;
                                return Container(
                                  //child: Center(child: Text('No data found!')),
                                );
                              } else {
                                return Container();
                              }
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
                              'No Data Found :(',
                            ),
                          ),
                        ),
                      );
              } else {
                return SliverToBoxAdapter(
                  child: Text(
                    'No Data Found :(',
                  ),
                );
              }
            })
      ],
    );
  }
}
