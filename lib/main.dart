import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/login/login_page.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

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
        primaryColorLight: RehabColors().mainColor,
      ),
      home: ScreenUtilInit(designSize: Size(1920, 1024), builder: () => LoginPage()),
    );
  }
}
