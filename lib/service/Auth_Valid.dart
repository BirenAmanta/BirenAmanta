import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resturant_app/screens//Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String uid;
  String userEmail;

  Future<User> registerWithEmailPassword(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

//signIn
  Future<User> signInWithEmailPassword(String email, String password) async {
    await Firebase.initializeApp();
    User user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Login.error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        Login.error = 'Wrong password provided.';
      }
    }
    return user;
  }
}
