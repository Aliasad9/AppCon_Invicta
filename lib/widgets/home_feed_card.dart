import 'package:flutter/material.dart';

class HomeFeedCard extends StatelessWidget {
  final imgData;
  final senderName;
  final receiverName;
  final timeAgo;
  final senderRole;
  final title;
  final cheerMsg;
  final color;
  final label;

  HomeFeedCard(this.imgData, this.senderName, this.receiverName, this.timeAgo,
      this.senderRole, this.title, this.cheerMsg, this.color, this.label);

  @override
  Widget build(BuildContext context) {
    var _color;
    var _label;
    if (color == 1) {
      _color = Colors.blue;
    } else if (color == 2) {
      _color = Colors.teal;
    } else if (color == 3) {
      _color = Colors.redAccent;
    } else if (color == 4) {
      _color = Colors.orange;
    } else if (color == 5) {
      _color = Colors.purple;
    } else {
      _color = Colors.blue;
    }
    if (label == 1) {
      _label = Icons.auto_awesome;
    } else if (label == 2) {
      _label = Icons.wine_bar;
    } else if (label == 3) {
      _label = Icons.favorite_border;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, left: 16, right: 16),
      child: Container(
        height: 232,
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
                            backgroundImage: imgData,
                          ),
                        ),
                        Text(
                          '${senderName.split(' ')[0]} Awarded ${receiverName.split(' ')[0]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '${timeAgo} ago',
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
                  '$senderRole ',
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
                  color: _color.withOpacity(0.32),
                  border: Border.all(color: _color),
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
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            '$title',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: _color,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 16),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            '$cheerMsg',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: _color,
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
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: _color),
                      child: Center(
                          child: Icon(
                        _label,
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
