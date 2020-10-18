import 'package:flutter/material.dart';


class HomeFeedCard extends StatelessWidget {
  const HomeFeedCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, left: 16, right: 16),
      child: Container(
        height: 224,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 9,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                        ),
                        Text(
                          'Ali Awarded You',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '2m ago',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF838383),
                      ),
                    )
                  ],
                ),
                Text(
                  'Software Developer at Google',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFFB5B5B5),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: 138,
              margin: EdgeInsets.symmetric(vertical: 22),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.32),
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16.0, bottom: 8.0),
                        child: Text(
                          'Welcome To The Team',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 16),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            'Collaboration with peers has never been more fun. Fostering a culture of incread productivity & employee satisfaction.',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                      child: Center(
                          child: Icon(
                            Icons.image_sharp,
                            color: Colors.white,
                            size: 30,
                          )),
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
