import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  final String name;
  final String position;
  final String imgUrl;
  final String role;
  final String company;
  final String level;

  LeaderboardCard({
    @required this.name,
    @required this.position,
    @required this.imgUrl,
    @required this.role,
    @required this.company,
    @required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return position != '1st'
        ? Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16,bottom: 32),
            child: Container(
              height: 72,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                  color: getColor(position).withOpacity(0.32),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: getColor(position))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8.0),
                    child: Text(
                      '$position',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        '$imgUrl',
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                        ],
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
                ],
              ),
            ),
          )
        : Container(
            height: 0,
            width: 0,
          );
  }

  getColor(position) {
    if (position == '2nd') {
      return Color(0xFFFFD400);
    } else if (position == '3rd') {
      return Colors.brown;
    } else {
      return Color(0xFFE0E0E0);
    }
  }
}
