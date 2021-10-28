import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';

import 'item_nav_bar_widget.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [true, false, false, false, false];
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  final NavigationBarController navigationBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 350.0,
          child: Column(
            children: [
              NavBarItem(
                icon: Icons.home,
                active: selected[0] && navigationBarController.index.value == 0,
                touched: () {
                  setState(() {
                    navigationBarController.index.value = 0;
                    select(navigationBarController.index.value);
                  });
                },
              ),
              NavBarItem(
                icon: Icons.person_add,
                active: selected[1] && navigationBarController.index.value == 1,
                touched: () {
                  setState(() {
                    navigationBarController.index.value = 1;
                    select(navigationBarController.index.value);
                  });
                },
              ),
              if (navigationBarController.password.value == 'asd123')
                NavBarItem(
                  icon: Icons.medical_services,
                  active: selected[2] && navigationBarController.index.value == 2,
                  touched: () {
                    setState(() {
                      navigationBarController.index.value = 2;
                      select(navigationBarController.index.value);
                    });
                  },
                ),
              if (navigationBarController.password.value == 'asd123')
                NavBarItem(
                  icon: Icons.people_alt_sharp,
                  active: selected[4] && navigationBarController.index.value == 4,
                  touched: () {
                    setState(() {
                      navigationBarController.index.value = 4;
                      select(navigationBarController.index.value);
                    });
                  },
                ),
            ],
          ),
        ));
  }
}
