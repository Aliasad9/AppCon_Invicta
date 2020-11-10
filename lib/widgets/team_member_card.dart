import 'package:Invicta/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  final user;
  final imgData;
  final isViewMoreVisible;

  TeamMemberCard(
      {@required this.user,
      @required this.imgData,
      @required this.isViewMoreVisible});

  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //     leading: CircleAvatar(radius: 28, backgroundImage: imgData),
  //     title: Text(
  //       '${user.name}',
  //       style: TextStyle(
  //         fontSize: 18,
  //         fontWeight: FontWeight.w400,
  //         fontFamily: 'OpenSans',
  //       ),
  //     ),
  //     subtitle: Row(
  //       children: [
  //         Text(
  //           '${user.role} at',
  //           style: TextStyle(
  //             fontSize: 10,
  //             fontWeight: FontWeight.w700,
  //             fontFamily: 'OpenSans',
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.only(left: 4),
  //           decoration: BoxDecoration(
  //               color: Theme.of(context).primaryColor.withOpacity(0.5),
  //               borderRadius: BorderRadius.circular(50)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(4.0),
  //             child: Text(
  //               '${user.companyName}',
  //               style: TextStyle(
  //                 fontSize: 10,
  //                 fontWeight: FontWeight.w700,
  //                 fontFamily: 'OpenSans',
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     trailing: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 16.0,
  //             top: 6,
  //           ),
  //           child: Text(
  //             'LVL \u2022 ${user.level.toString()}',
  //             style: TextStyle(
  //               color: Colors.black38,
  //               fontSize: 10,
  //               fontWeight: FontWeight.w700,
  //               fontFamily: 'OpenSans',
  //             ),
  //           ),
  //         ),
  //         Visibility(
  //           visible: this.isViewMoreVisible,
  //           child: InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (_) => ProfileScreen(false, user)));
  //             },
  //             child: Container(
  //               child: Flexible(
  //                 child: Text(
  //                   "View Profile",
  //                   style: TextStyle(
  //                     color: Theme.of(context).primaryColor,
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.w700,
  //                     fontFamily: 'OpenSans',
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 32),
      child: Container(
        height: 72,
        width: MediaQuery.of(context).size.width - 24,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(radius: 28, backgroundImage: imgData),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              '${user.name}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${user.role} at',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${user.companyName}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 16),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(

                            top: 6,
                          ),
                          child: Text(
                            'LVL \u2022 ${user.level.toString()}',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Visibility(
                          visible: this.isViewMoreVisible,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ProfileScreen(false, user)),);
                            },
                            child: Container(
                              child: Text(
                                "View Profile",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
