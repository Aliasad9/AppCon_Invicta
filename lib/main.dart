import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signin.dart';
import 'signup.dart';
import 'welcome.dart';


Future<void> main() async {
  //Allowing precaching method to be called before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  //Precaching svg to reduce delay
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/images/illust.svg'), null);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xFF6892FF),scaffoldBackgroundColor: Colors.white,),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        // '/chat':(BuildContext context)=> new ChatScree(),
        // '/teams':(BuildContext context)=> new Teams(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/signin': (BuildContext context) => new SignIn(),
      },
    );
  }

}
