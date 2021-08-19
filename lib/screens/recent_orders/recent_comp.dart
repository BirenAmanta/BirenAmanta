import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/service/getValue.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class RecentOrderComp extends StatefulWidget {
  const RecentOrderComp({Key key}) : super(key: key);
  @override
  _RecentOrderComp createState() => _RecentOrderComp();
}

class _RecentOrderComp extends State<RecentOrderComp> {
  Future<List> getName() async {
    var _auth = FirebaseAuth.instance.currentUser;
    String name = "";
    Map m = await GetValue().searchByEmail(_auth.email);
    name = m["Name"];
    var date = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(date);
    print(formatted);
    var b = await GetValue.getOrderbyDate(name, formatted);
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: FutureBuilder(
          //initialData: [],
          future: getName(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            // print(snapshot.data);
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
