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
    if (list.length > 0 && email != null) {
      user = CustomUser.fromJson(list[0]);
      print(user.name);
      prefs.setString('name', user.name);
      prefs.setString('imgUrl', user.imgUrl);
      prefs.setString('role', user.role);
      prefs.setString('companyName', user.companyName);
      prefs.setInt('points', user.points);
      prefs.setInt('level', user.level);
      prefs.setDouble('category1', user.category1);
      prefs.setDouble('category2', user.category2);
      prefs.setDouble('category3', user.category3);
      prefs.setDouble('category4', user.category4);
      prefs.setDouble('category5', user.category5);
      imgUrl = user.imgUrl;
      name = user.name;
      companyName = user.companyName;
    }
  } on Exception catch (e) {
    imgUrl = '';
    name = '';
    companyName = '';
    user = CustomUser.name('', '', '', '', '', 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0);
  }
  if (user == null) {
    imgUrl = null;
    name = null;
    companyName = null;
    email=null;
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
    runApp(new MyApp(email, imgUrl, companyName, name, user));
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
