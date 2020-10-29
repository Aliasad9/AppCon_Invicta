import 'package:Invicta/data/user.dart';
import 'package:Invicta/screens/navigation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';

final databaseReference = FirebaseFirestore.instance;

Future<void> main() async {
  //Allowing precaching method to be called before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  //Precaching svg to reduce delay
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/illust.svg'),
      null);
  await Firebase.initializeApp();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var email = prefs.getString('email');

  var name = prefs.getString('name');
  var imgUrl = prefs.getString('imgUrl');
  // var role = prefs.getString('role');
  var companyName = prefs.getString('companyName');
  // var points = prefs.getInt('points');
  // var level = prefs.getInt('level');
  // var category1 = prefs.getInt('category1');
  // var category2 = prefs.getInt('category2');
  // var category3 = prefs.getInt('category3');
  // var category4 = prefs.getInt('category4');
  // var category5 = prefs.getInt('category5');
  // var teamList = [];
  // await databaseReference
  //     .collection("users")
  //     .where("companyName", isEqualTo: companyName)
  //     .get()
  //     .then((QuerySnapshot snapshot) {
  //   snapshot.docs.forEach((f) {
  //     teamList.add(CustomUser.name(
  //         f.data()['email'],
  //         f.data()['name'],
  //         f.data()['imgUrl'],
  //         f.data()['role'],
  //         f.data()['companyName'],
  //         f.data()['points'],
  //         f.data()['level'],
  //         f.data()['category1'],
  //         f.data()['category2'],
  //         f.data()['category3'],
  //         f.data()['category4'],
  //         f.data()['category5']));
  //   });
  // });
  //Fixing Screen Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp(email, imgUrl,companyName,name));
  });
}

class MyApp extends StatefulWidget {
  final email;
  final imgUrl;
  final companyName;
  final name;


  MyApp(this.email, this.imgUrl, this.companyName, this.name);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invicta',
      theme: ThemeData(
        primaryColor: Color(0xFF6892FF),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: this.widget.email != null
          ? NavigationScreen(this.widget.imgUrl, this.widget.companyName, this.widget.name)
          : WelcomePage(),
    );
  }
}
