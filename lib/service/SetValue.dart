import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';

class SetValue {
  final String name, email;
  static String fname = "No Image";
  FirebaseFirestore auth = FirebaseFirestore.instance;
  SetValue(this.name, this.email);
  set() {
    auth.collection("Restaurant").doc(email).set(
      {
        "Name": name,
        "Address": "",
      },
    );
  }

  static setField(Map<String, String> m, String address) {
    User _auth = FirebaseAuth.instance.currentUser;
    if (address.isEmpty)
      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(_auth.email)
          .update({
        "dish": FieldValue.arrayUnion([m])
      });
    else {
      FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(_auth.email)
          .update({
        "Address": address,
        "dish": FieldValue.arrayUnion([m])
      });
    }
  }

  static Future<Uri> downloadUrl(String path) async {
    print(fb
        .storage()
        .refFromURL('gs://delieveryapp-913a0.appspot.com')
        .child(path)
        .getDownloadURL()
        .toString());
    return await fb
        .storage()
        .refFromURL('gs://delieveryapp-913a0.appspot.com')
        .child(path)
        .getDownloadURL();
  }
}
