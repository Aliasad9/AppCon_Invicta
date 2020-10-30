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
  var imgUrl;
  var name;
  var companyName;
  var user;
  var email;
  try {
    email = prefs.getString('email');
    var list = [];
    await databaseReference
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((value) =>
            value.docs.forEach((element) => list.add(element.data())));
    user = CustomUser.fromJson(list[0]);
    print(user.name);
    name = prefs.setString('name', user.name);
    imgUrl = prefs.setString('imgUrl', user.imgUrl);
    var role = prefs.setString('role', user.role);
    companyName = prefs.setString('companyName', user.companyName);
    var points = prefs.setInt('points', user.points);
    var level = prefs.setInt('level', user.level);
    var category1 = prefs.setDouble('category1', user.category1);
    var category2 = prefs.setDouble('category2', user.category2);
    var category3 = prefs.setDouble('category3', user.category3);
    var category4 = prefs.setDouble('category4', user.category4);
    var category5 = prefs.setDouble('category5', user.category5);
  } on Exception catch (e) {
    imgUrl = null;
    name = null;
    companyName = null;
    user = null;
  }

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
    runApp(
        new MyApp(user.email, user.imgUrl, user.companyName, user.name, user));
  });
}

class MyApp extends StatefulWidget {
  final email;
  final imgUrl;
  final companyName;
  final name;
  final user;

  MyApp(this.email, this.imgUrl, this.companyName, this.name, this.user);

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
          ? NavigationScreen(this.widget.imgUrl, this.widget.companyName,
              this.widget.name, this.widget.email, this.widget.user)
          : WelcomePage(),
    );
  }
}
