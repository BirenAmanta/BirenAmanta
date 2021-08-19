import 'dart:html';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:resturant_app/service/SetValue.dart';
import 'package:resturant_app/service/getValue.dart';

class AddMenuComp extends StatefulWidget {
  const AddMenuComp({Key key}) : super(key: key);

  @override
  _AddMenuCompState createState() => _AddMenuCompState();
}

class _AddMenuCompState extends State<AddMenuComp> {
  User _auth = FirebaseAuth.instance.currentUser;
  String s = "No Image";
  String address = "";
  bool on = false;
  setImage(String name) {
    User _auth = FirebaseAuth.instance.currentUser;
    FileUploadInputElement upload = FileUploadInputElement()
      ..accept = 'Image/*';
    upload.click();
    upload.onChange.listen((event) {
      final file = upload.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      setState(() {
        s = file.name.toString();
      });

      reader.onLoadEnd.listen((event) {
        print("Done");
      });
      final path = 'Restaurant/$name';
      fb
          .storage()
          .refFromURL('gs://delieveryapp-913a0.appspot.com')
          .child(path)
          .put(file);
    });
  }

  Map<String, String> m = {"Cuisine": "", "Name": "", "Price": "", "pic": ""};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: on,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter Address"),
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter Cuisine"),
                    onChanged: (value) {
                      m["Cuisine"] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter Name"),
                    onChanged: (value) {
                      m["Name"] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter Price"),
                    onChanged: (value) {
                      m["Price"] = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s),
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          setImage(m["Name"]);
                        },
                      )
                    ],
                  ),
                  Center(
                      child: ElevatedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      setState(() {
                        on = true;
                      });
                      var l = await FirebaseStorageInstance.loadimage(
                          context, "Restaurant/${m["Name"]}");
                      setState(() {
                        print(l.toString());
                        m["pic"] = l.toString();
                      });
                      SetValue.setField(m, address);
                      setState(() {
                        if (m["pic"].isNotEmpty) on = false;
                        s = "No Image";
                      });
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
