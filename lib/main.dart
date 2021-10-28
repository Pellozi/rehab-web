import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/login/login_page.dart';
import 'package:rehab_web/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rehab.it',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: RehabColors().mainColor,
      ),
      home: LoginPage(),
    );
  }
}
