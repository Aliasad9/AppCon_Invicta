import 'package:Invicta/data/user.dart';
import 'package:Invicta/main.dart';
import 'package:Invicta/screens/admin_screen.dart';
import 'package:Invicta/screens/navigation_screen.dart';
import 'package:Invicta/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  SignIn();

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Map<String, dynamic> _formData = {
    "email": null,
    "password": null,
    "acceptTerms": false,
  };
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool acceptTerms = true;
  String email = '';
  String password = '';
  bool _obscure = true;

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty || !value.trimRight().contains("@")) {
          return ("Please provide a valid email account!");
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      //keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty || value.length < 4) {
          return "Please provide a valid password ";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      obscureText: _obscure,
      onSaved: (String value) {
        setState(() {
          _formData['password'] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 24,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(36),
                            bottomLeft: Radius.circular(36))),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: 100,
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
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Arvo',
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 80),
                      child: Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Arvo'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(top: 230),
                      child: Text(
                        'Login To Your Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Arvo'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: _buildEmailTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: _buildPasswordField(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                      child: Container(
                        height: 30,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupPage()));
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _signInWithEmailAndPassword();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2D67FF),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      showAlertDialog(context);
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      SharedPreferences prefs = await _prefs;
      CustomUser customUser;
      var list = [];
      await databaseReference
          .collection('users')
          .where('email', isEqualTo: _emailController.text)
          .get()
          .then((value) =>
              value.docs.forEach((element) => list.add(element.data())));
      customUser = CustomUser.fromJson(list[0]);
      var isAdmin = list[0]['isAdmin'];

      prefs.setString('email', customUser.email);
      prefs.setString('name', customUser.name);
      prefs.setString('imgUrl', customUser.imgUrl);
      prefs.setString('role', customUser.role);
      prefs.setString('companyName', customUser.companyName);
      prefs.setInt('points', customUser.points);
      prefs.setInt('level', customUser.level);
      prefs.setDouble('category1', customUser.category1);
      prefs.setDouble('category2', customUser.category2);
      prefs.setDouble('category3', customUser.category3);
      prefs.setDouble('category4', customUser.category4);
      prefs.setDouble('category5', customUser.category5);
      print(isAdmin);
      Navigator.pop(context);
      if (isAdmin==true) {
        prefs.setBool('isAdmin', isAdmin);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => AdminProfile(customUser),
            ),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => NavigationScreen(
                  customUser.imgUrl,
                  customUser.companyName,
                  customUser.name,
                  _emailController.text,
                  customUser),
            ),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text('${e.message}'),
        duration: Duration(seconds: 3),
      ));
      Navigator.pop(context);
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(
                "Loading",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
