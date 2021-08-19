import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resturant_app/constants.dart';
import 'package:resturant_app/screens/orders/Orders.dart';
import 'package:resturant_app/service//Auth_Valid.dart';

import 'Registration.dart';

class Login extends StatefulWidget {
  static final String screenId = "LoginScreen";
  static String error = "";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  bool showSpinning = false;
  String email = "";
  String password = "";
  String error = "";
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant Panel Log In",
        ),
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
            height: 350.0,
            width: 350.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: Deco.copyWith(
                        hintText: "Enter Email Address",
                        prefixIcon: Icon(Icons.email_rounded)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: Deco.copyWith(
                        hintText: 'Enter your password.',
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red[500],
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Material(
                      color: Colors.lightBlueAccent[400],
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            showSpinning = true;
                          });
                          try {
                            final user = await auth()
                                .signInWithEmailPassword(email, password);
                            if (user != null) {
                              setState(() {
                                showSpinning = false;
                              });
                              Navigator.pushNamed(context, Orders.screenId);
                            } else {
                              setState(() {
                                showSpinning = false;
                                error = Login.error;
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Log In',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Material(
                      color: Colors.deepPurpleAccent[200],
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Registration.screenId);
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
    );
  }
}
