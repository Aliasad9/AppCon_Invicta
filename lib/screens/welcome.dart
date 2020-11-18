import 'package:Invicta/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Container(

                          child: Image.asset('assets/images/logo.png',width: 30, height: 30,),
                        ),
                      ),
                      Text(
                        "Invicta",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arvo',
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Every Employee is Special",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Arvo"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "And So are You!",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Arvo",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: SvgPicture.asset(
                  'assets/images/illust.svg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: FlatButton(
                    onPressed: () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignIn()));
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          height: 18,
                          width: 18,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF2D67FF), shape: BoxShape.circle),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
