import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'screens/welcome.dart';


Future<void> main() async {
  //Allowing precaching method to be called before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  //Precaching svg to reduce delay
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/images/illust.svg'), null);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invicta',
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
