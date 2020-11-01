import 'package:Invicta/screens/profile_screen.dart';
import 'package:Invicta/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final imageData;
  final user;

  const CustomAppBar(this.imageData, this.user);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.white,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 8,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Invicta",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen(true, user)));//TODO: Pass user here
              },
              child: ProfileImage(
                imageData: imageData,
                imgDiameter: 40.0,
                borderDiameter: 48.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
