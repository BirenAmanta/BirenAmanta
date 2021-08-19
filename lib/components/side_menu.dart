import 'package:flutter/material.dart';
import 'package:resturant_app/screens/AddMenu/add_menu.dart';
import 'package:resturant_app/screens/orders/Orders.dart';
import 'package:resturant_app/screens/recent_orders/recent.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Container(
          width: 250,
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset("images/Restaurant-Logo.png"),
              ),
              DrawerListTile(
                title: "Orders",
                press: () {
                  Navigator.of(context).pushNamed(Orders.screenId);
                },
              ),
              DrawerListTile(
                title: "Add Menu",
                press: () {
                  Navigator.of(context).pushNamed(AddMenu.screenId);
                },
              ),
              DrawerListTile(
                title: "Recent Orders",
                press: () {
                  Navigator.of(context).pushNamed(RecentOrders.screenId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    //required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
