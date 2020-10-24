import 'package:flutter/material.dart';

class TeamGridAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: Wrap(
          children: [
            TeamContainer(),
            TeamContainer(),
            TeamContainer(),
            TeamContainer(),
            TeamContainer(),
            TeamContainer(),
            TeamContainer(),
            TeamContainer()
          ],
        ),
      ),
    );
  }
}

class TeamContainer extends StatelessWidget {
  const TeamContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.32),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green)),
        height: 105,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star_border,
                        color: Colors.white,
                      )),
                ),
                Text(
                  'Alfabolt',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:4.0, horizontal: 8),
              child: Text(
                'Web Dev Compnay',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'View Full Team',
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 9,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
