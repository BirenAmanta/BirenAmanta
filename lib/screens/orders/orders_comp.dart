import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/service/getValue.dart';

import '../../constants.dart';

class OrderComp extends StatefulWidget {
  const OrderComp({Key key}) : super(key: key);
  @override
  _OrderCompState createState() => _OrderCompState();
}

class _OrderCompState extends State<OrderComp> {
  Future<List> getName() async {
    var _auth = FirebaseAuth.instance.currentUser;
    String name = "";
    Map m = await GetValue().searchByEmail(_auth.email);
    name = m["Name"];
    var b = await GetValue.getOrder(name);
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: FutureBuilder(
          future: getName(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return DataTable(
                columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Dish")),
                  DataColumn(label: Text("Price"))
                ],
                rows: List.generate(snapshot.data.length,
                    (index) => recentFileDataRow(snapshot.data[index])),
              );
            if (snapshot.connectionState == ConnectionState.waiting)
              return DataTable(
                columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Dish")),
                  DataColumn(label: Text("Price"))
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(CircularProgressIndicator()),
                      DataCell(CircularProgressIndicator()),
                      DataCell(CircularProgressIndicator()),
                      DataCell(CircularProgressIndicator()),
                    ],
                  )
                ],
              );
            return DataTable(
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Address")),
                DataColumn(label: Text("Dish")),
                DataColumn(label: Text("Price"))
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text("Null")),
                    DataCell(Text("Null")),
                    DataCell(Text("Null")),
                    DataCell(Text("Null")),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  DataRow recentFileDataRow(QueryDocumentSnapshot fileInfo) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.data()["Name"].toString())),
        DataCell(Text(fileInfo.data()["Address"].toString())),
        DataCell(Text(fileInfo.data()["Dish"].toString())),
        DataCell(Text(fileInfo.data()["Price"].toString())),
      ],
    );
  }
}
