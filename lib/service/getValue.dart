import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';

class GetValue {
  Future<Map> searchByEmail(String name) async {
    Map m = new Map();
    var b = await FirebaseFirestore.instance
        .collection("Restaurant")
        .where("Name", isEqualTo: name)
        .get();
    b.docs.forEach((res) {
      m = res.data();
    });

    return m;
  }

  static Future<List> getOrder(String email) async {
    List m = [];
    var b = await FirebaseFirestore.instance
        .collection("Orders")
        .where("Rest", isEqualTo: email)
        .get();
    for (var r in b.docs) {
      m.add(r);
    }
    print(m.toString());
    return m;
  }

  static Future<List> getOrderbyDate(String email, String date) async {
    List m = [];
    var b = await FirebaseFirestore.instance
        .collection("Orders")
        .where("Rest", isEqualTo: email)
        .where("Date", isEqualTo: date)
        .get();
    for (var r in b.docs) {
      m.add(r);
    }
    print(m.toString());
    return m;
  }
}

class FirebaseStorageInstance extends ChangeNotifier {
  FirebaseStorageInstance() {
    initializeApp(
        apiKey: "AIzaSyAHaSs1exGULmK-vQtuN-BjBUhD2E9yWwM",
        authDomain: "delieveryapp-913a0.firebaseapp.com",
        databaseURL: "https://delieveryapp-913a0-default-rtdb.firebaseio.com",
        projectId: "delieveryapp-913a0",
        storageBucket: "delieveryapp-913a0.appspot.com",
        messagingSenderId: "21854523941",
        appId: "1:21854523941:web:24ae48e9efcba8f8cfe5cc",
        measurementId: "G-BCMXYVRKHW");
  }
  static Future<dynamic> loadimage(
      BuildContext context, String imageName) async {
    return await fb
        .storage()
        .refFromURL('gs://delieveryapp-913a0.appspot.com')
        .child(imageName)
        .getDownloadURL();
  }
}
