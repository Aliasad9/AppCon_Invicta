import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  final String name;

  final String imgUrl;
  final String role;
  final String company;
  final String level;

  TeamMemberCard({
    @required this.name,
    @required this.imgUrl,
    @required this.role,
    @required this.company,
    @required this.level,
  });

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
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(
                  '$imgUrl',
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$role at',
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
                                '$company',
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 6,
                          ),
                          child: Text(
                            'LVL \u2022 $level',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Flexible(
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
