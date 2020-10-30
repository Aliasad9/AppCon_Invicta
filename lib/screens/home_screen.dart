import 'package:Invicta/data/cheer.dart';
import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
import 'package:Invicta/widgets/home_feed_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String email;

  HomeScreen(this.name, this.email);

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
                .where("senderEmail", isEqualTo: this.widget.email)
                .where('receiverEmail', isEqualTo: this.widget.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Text(
                    'No Cheers Found :(',
                  ),
                );
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
                                cheer.createdAt.difference(dateTimeNow).inDays;
                            if (day < 1) {
                              var hrs = cheer.createdAt
                                  .difference(dateTimeNow)
                                  .inHours;
                              if (hrs < 1) {
                                var min = cheer.createdAt
                                    .difference(dateTimeNow)
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
                                cheer.color);
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
              // return SliverList(
              //   delegate: new SliverChildListDelegate(_buildListItems(10)),
              // );
            })
      ],
    );
  }


}
