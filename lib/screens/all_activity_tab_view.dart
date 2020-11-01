import 'package:Invicta/data/cheer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/home_feed_card.dart';

class AllActivity extends StatefulWidget {
  @override
  _AllActivityState createState() => _AllActivityState();
}

class _AllActivityState extends State<AllActivity> {
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
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("cheers")
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return (snapshot.hasData && snapshot.data.size > 0)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var fetchedJsonData =
                                snapshot.data.docs[index].data();
                            Cheer cheer = Cheer.fromJson(fetchedJsonData);

                            DateTime dateTimeNow = DateTime.now();

                            var timeAgo = '';
                            var day =
                                dateTimeNow.difference(cheer.createdAt).inDays;
                            if (day < 1) {
                              var hrs = dateTimeNow
                                  .difference(cheer.createdAt)
                                  .inHours;
                              if (hrs < 1) {
                                var min = dateTimeNow
                                    .difference(cheer.createdAt)
                                    .inMinutes;
                                timeAgo = min.toString() + 'min';
                              } else {
                                timeAgo = hrs.toString() + 'hrs';
                              }
                            } else {
                              timeAgo = day.toString() + 'days';
                            }

                            return HomeFeedCard(
                              cheer.senderImgData,
                              cheer.senderName,
                              cheer.receiverName,
                              timeAgo,
                              cheer.senderRole,
                              cheer.title,
                              cheer.cheerMsg,
                              cheer.color,
                              cheer.label,
                            );
                          },
                          childCount: snapshot.data.size,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          child: Center(
                            child: Text(
                              'No Cheers Found :(',
                            ),
                          ),
                        ),
                      );
              } else {
                return SliverToBoxAdapter(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}
