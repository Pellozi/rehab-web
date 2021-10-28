import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/standard_widgets/item_nav_bar_widget.dart';
import 'package:rehab_web/ui/standard_widgets/nav_bar_item.dart';
import 'package:rehab_web/ui/standard_widgets/title_nav_bar_widget.dart';
import 'package:rehab_web/utils/colors.dart';

import 'controller/navigation_bar_controller.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final NavigationBarController navigationBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100.0,
        color: RehabColors().mainColor,
        child: Stack(
          children: [
            TitleNavigationBar(),
            Align(
              alignment: Alignment.center,
              child: NavBar(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavBarItem(
                touched: () {
                  navigationBarController.index.value = 0;
                  Get.back();
                },
                icon: Icons.logout,
                active: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
