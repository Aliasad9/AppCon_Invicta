import 'package:Invicta/screens/admin_screen.dart';
import 'package:Invicta/screens/extra_info_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  SignupPage();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignupPage> {
  final databaseReference = FirebaseFirestore.instance;

  final Map<String, dynamic> _formData = {
    "email": null,
    "password": null,
    "acceptTerms": false,
  };
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool acceptTerms = true;
  String email = '';
  String password = '';
  bool _success;

  bool _obscure = true;
  @override
  void dispose() {
    _scaffoldKey.currentState.dispose();
    _formKey.currentState.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  //bool _acceptTerms = false;
  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        return (!regex.hasMatch(value)) ? 'Invalid email address' : null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      //keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if (_passwordController.text != value) {
          return "Passwords donot match ";
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(left: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      obscureText: _obscure,
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
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(left: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
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
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        CupertinoIcons.back,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 140,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Container(

                                              child: Image.asset('assets/images/logo.png',width: 40, height: 40,),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "Join the Club",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Arvo"),
                              ),
                            ),
                            Text(
                              "Sign-up for the Account!",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Arvo"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.35),
                          border: Border.fromBorderSide(
                            BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getLabel('Email'),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: _buildEmailTextField(),
                                ),
                                getLabel('Password'),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: _buildPasswordField(),
                                ),
                                getLabel('Confirm Password'),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: _buildConfirmPasswordField(),
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
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Have an Account?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _register(context);
                            }

                          },
                          child: Container(
                            height: 50,
                            width: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Sign Up",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getCompanies() async {
    var list = [];
    var count = 0;
    await databaseReference
        .collection('Companies')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        list.add(Company(count, f.data()['companyName']));
        count += 1;
      });
    });
    return list;
  }

  _getRoles() async {
    var list = [];
    var count = 0;
    await databaseReference
        .collection('Roles')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        list.add(
            Role.name(count, f.data()['roleName'], f.data()['companyName']));
        count += 1;
      });
    });
    return list;
  }

  Padding getLabel(label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        '$label',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void _register(context) async {
    User user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      showAlertDialog(context);
      var email = _emailController.text;
      var companiesList = await _getCompanies();
      var rolesList = await _getRoles();
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ExtraInfoScreen(email, companiesList, rolesList)));
    } on FirebaseAuthException catch (e) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text('${e.message}'),
      ));
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "Loading...",
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
