import 'package:Invicta/data/cheer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final companyName;

  NotificationScreen(this.companyName);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          leading: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          title: Row(
            children: [
              Text(
                "Notifications",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Arvo',
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 8),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      "notifications") //.where("companyName", isEqualTo: this.widget.companyName)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.black38,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      '${snapshot.data.docs[index].data()['senderName']} sent cheer to ${snapshot.data.docs[index].data()['receiverName']}'),
                                ),
                                Text('${Cheer.createdAtToDifference(snapshot.data.docs[index].data()['createdAt'].toDate())} ago'),
                              ],
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data.docs[index]
                                      .data()['senderImgUrl'])),
                              title: Text(
                                  '${snapshot.data.docs[index].data()['title']}'),
                              subtitle: Text(
                                  '${snapshot.data.docs[index].data()['cheerMsg']}'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
