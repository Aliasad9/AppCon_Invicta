import 'package:Invicta/data/user.dart';
import 'package:Invicta/widgets/custom_sliver_app_bar.dart';
import 'package:Invicta/widgets/team_member_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamMembers extends StatefulWidget {
  final companyName;
  final email;

  TeamMembers(this.companyName, this.email);

  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(
            title: 'Your Amazing Team',
            height: 285,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("companyName", isEqualTo: this.widget.companyName)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return (snapshot.hasData && snapshot.data.size > 0)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var fetchedJsonData =
                                snapshot.data.docs[index].data();

                            CustomUser user =
                                CustomUser.fromJson(fetchedJsonData);
                            var imgUrl = user.imgUrl;
                            var isViewMoreVisible = true;
                            if (this.widget.email == user.email) {
                              isViewMoreVisible = false;
                            }
                            return TeamMemberCard(
                              isViewMoreVisible: isViewMoreVisible,
                              user: user,
                              imgData: NetworkImage(imgUrl != null
                                  ? imgUrl
                                  : 'https://firebasestorage.googleapis.com/v0/b/invicta-c7073.appspot.com/o/profile_images%2Fimage_picker3178190758274656164.jpg?alt=media&token=f8462177-42c8-4975-b9b0-76792af7624e'),
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
                              'No Team Members Found :(',
                            ),
                          ),
                        ),
                      );
              } else {
                return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        ],
      ),
    );
  }
}
