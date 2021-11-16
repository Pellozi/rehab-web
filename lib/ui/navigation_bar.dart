import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/login/login_page.dart';
import 'package:rehab_web/ui/standard_widgets/item_nav_bar_widget.dart';
import 'package:rehab_web/ui/standard_widgets/nav_bar_item.dart';
import 'package:rehab_web/ui/standard_widgets/title_nav_bar_widget.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
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
        height: 70.w,
        color: RehabColors().mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleNavigationBar(),
            Align(
              alignment: Alignment.center,
              child: NavBar(),
            ),
            NavBarItem(
              title: 'Sair',
              touched: () {
                navigationBarController.index.value = 0;
                Get.offAll(LoginPage());
              },
              icon: Icons.logout,
              active: false,
            ),
          ],
        ),
      ),
    );
  }
}
