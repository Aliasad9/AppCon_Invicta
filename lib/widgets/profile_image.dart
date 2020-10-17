import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {Key key,
        @required this.profileImgUrl,
        @required this.imgDiameter,
        @required this.borderDiameter})
      : super(key: key);

  final String profileImgUrl;
  final double imgDiameter;
  final double borderDiameter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: borderDiameter,
        height: borderDiameter,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
            width: imgDiameter,
            height: imgDiameter,
            child: CircleAvatar(
              backgroundImage: AssetImage(profileImgUrl),
            ),
          ),
        ),
      ),
    );
  }
}
