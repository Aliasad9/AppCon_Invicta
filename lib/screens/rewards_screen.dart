import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Directory _appDocsDir;

class RewardsScreen extends StatefulWidget {
  final myEmail;

  RewardsScreen(this.myEmail);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {

  File fileFromDocsDir(String filename) {
    String pathName = p.join(_appDocsDir.path, filename);
    return File(pathName);
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => getDirectory());
  }
  getDirectory() async{
    _appDocsDir = await getApplicationDocumentsDirectory();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              Text(
                "Rewards",
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
                  .collection("rewards")
                  .where("receiverEmail", isEqualTo: this.widget.myEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index) {

                      return InkWell(
                        onTap: (){
                          AlertDialog alert = AlertDialog(

                            content: Image(
                              width:MediaQuery.of(context).size.width-32,
                              height: MediaQuery.of(context).size.height-32,
                              image: NetworkToFileImage(
                                url: snapshot.data.docs[index]
                                    .data()['imageUrl'],
                                file: fileFromDocsDir(
                                    "${snapshot.data.docs[index].data()['imageUrl'].split('/')[snapshot.data.docs[index].data()['imageUrl'].split('/').length-1]}.png"),

                              ),
                            ),
                            actions: [
                              FlatButton(
                                child: Text('OK'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                width:100,
                                height: 150,
                                image: NetworkToFileImage(
                                  url: snapshot.data.docs[index]
                                      .data()['imageUrl'],
                                  file: fileFromDocsDir(
                                      "${snapshot.data.docs[index].data()['imageUrl'].split('/')[snapshot.data.docs[index].data()['imageUrl'].split('/').length-1]}.png"),

                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${snapshot.data.docs[index].data()['senderName'].split(' ')[0]} sent a gift ${snapshot.data.docs[index].data()['receiverName'].split(' ')[0]}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('Gift card worth \$100',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Text('No rewards found'),
                );
              }),
        ),
      ),
    );
  }
}
