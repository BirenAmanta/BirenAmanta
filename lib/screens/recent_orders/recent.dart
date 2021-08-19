import 'package:flutter/material.dart';
import 'package:resturant_app/components/side_menu.dart';
import 'package:resturant_app/screens/recent_orders/recent_comp.dart';

import '../../constants.dart';
import '../../responsive.dart';

class RecentOrders extends StatelessWidget {
  static const String screenId = "RecentOrders";
  const RecentOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) || Responsive.isTablet(context)) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            "Orders",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        drawer: Responsive.isDesktop(context) ? null : SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: RecentOrderComp(), // DashboardScreen(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        // key: context.read<MenuController>().scaffoldKey,
        //drawer: Responsive.isDesktop(context) ? null : SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: RecentOrderComp(), //DashboardScreen(),
              ),
            ],
          ),
        ),
      );
    }
  }
}
