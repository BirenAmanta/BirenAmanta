import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/screens/Login.dart';
import 'package:resturant_app/screens/Registration.dart';
import 'package:resturant_app/screens/orders/Orders.dart';
import 'package:resturant_app/screens/recent_orders/recent.dart';
import 'constants.dart';
import 'screens/AddMenu/add_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: Login.screenId,
      routes: {
        AddMenu.screenId: (context) => AddMenu(),
        Orders.screenId: (context) => Orders(),
        Login.screenId: (context) => Login(),
        Registration.screenId: (context) => Registration(),
        RecentOrders.screenId: (context) => RecentOrders(),
      },
    );
  }
}
