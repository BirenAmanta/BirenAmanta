//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resturant_app/constants.dart';
import 'package:resturant_app/service/Auth_Valid.dart';
import 'package:resturant_app/service/SetValue.dart';

import 'Login.dart';

class Registration extends StatefulWidget {
  static final String screenId = "Registration";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Registration> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool showSpinning = false;
  String email, name;
  Image image;
  // ignore: non_constant_identifier_names
  TextEditingController password = TextEditingController();
  TextEditingController confirmPw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[400],
      appBar: AppBar(
        title: Text(
          "Restaurant Panel Registration In",
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        backgroundColor: Colors.indigo[500],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinning,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: const Offset(
                    8.0,
                    8.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: bgColor,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            height: 500.0,
            width: 400.0,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: Deco.copyWith(
                            hintText: "Enter Username",
                            prefixIcon: Icon(Icons.person)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        //obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: Deco.copyWith(
                            hintText: 'Enter Email Address',
                            prefixIcon: Icon(Icons.email)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        //obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Password';
                          }
                          return null;
                        },
                        decoration: Deco.copyWith(
                            hintText: 'Enter new  Password',
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: confirmPw,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          print(password.text);
                          print(confirmPw.text);
                          if (password.text != confirmPw.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        decoration: Deco.copyWith(
                            hintText: 'Enter Confirm  Password',
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        color: Colors.deepPurpleAccent[200],
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              showSpinning = true;
                            });
                            if (_formkey.currentState.validate()) {
                              try {
                                final user = await auth()
                                    .registerWithEmailPassword(
                                        email, password.text);
                                // ignore: unnecessary_null_comparison
                                if (user != null) {
                                  SetValue(name, user.email).set();
                                  setState(() {
                                    showSpinning = false;
                                  });
                                  Navigator.pushNamed(context, Login.screenId);
                                }
                              } catch (e) {
                                print(e);
                              }
                              print(email);
                              print(password);
                            } else {
                              print("UnSuccessfull");
                              setState(() {
                                showSpinning = false;
                              });
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Register',
                          ),
                        ),
                      ),
                    ),
                    //),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
