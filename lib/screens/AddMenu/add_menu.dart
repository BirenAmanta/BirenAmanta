import 'package:flutter/material.dart';
import 'package:resturant_app/components/side_menu.dart';
import 'package:resturant_app/screens/AddMenu/add_menu_comp.dart';

import '../../constants.dart';
import '../../responsive.dart';

class AddMenu extends StatelessWidget {
  static const String screenId = "AddMenu";
  const AddMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) || Responsive.isTablet(context)) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(
            "Add Menu",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        drawer: Responsive.isDesktop(context) ? null : SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: AddMenuComp(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: AddMenuComp(),
              ),
            ],
          ),
        ),
      );
    }
  }
}
