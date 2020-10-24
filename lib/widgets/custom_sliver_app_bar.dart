import 'package:flutter/material.dart';
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: 308,
      collapsedHeight: 80,
      automaticallyImplyLeading: false,
      centerTitle: false,
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Padding(
          padding: const EdgeInsets.only(top: 80, left: 16.0),
          child: Text(
            '$title',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.w700,
              fontSize: 45,
            ),
          ),
        ),
      ),
    );
  }
}