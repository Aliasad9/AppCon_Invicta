import 'package:Invicta/awais/admin_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignupPage> {
  final Map<String, dynamic> _formData = {
    "email": null,
    "password": null,
    "acceptTerms": false,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool acceptTerms = true;
  String email = '';
  String password = '';
  bool _obscure = true;

  //bool _acceptTerms = false;
  Widget _buildEmailTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty || !value.trimRight().contains("@")) {
          return ("Please provide a valid email accout!");
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

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if (_passwordcontroller.text != value) {
          return "Passwords donot match ";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),
      obscureText: _obscure,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordcontroller,
      validator: (value) {
        if (value.isEmpty || value.length < 8) {
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
    return SafeArea(
      child: Scaffold(
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
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
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
                  height: MediaQuery.of(context).size.height*0.5,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.35),
                          border: Border.fromBorderSide(
                            BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _buildEmailTextField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _buildPasswordField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _buildConfirmPasswordField(),
                              ),

                            ],
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
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminProfile()));
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
                                  width: 20,height: 20,
                                  decoration:
                                  BoxDecoration(color: Color(0xFF2D67FF), shape: BoxShape.circle),
                                  child: Icon(Icons.arrow_forward, color:Colors.white,size: 18,),
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
}
