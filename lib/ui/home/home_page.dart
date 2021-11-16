import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/home/doctors_page.dart';
import 'package:rehab_web/ui/new_doctor/new_doctor_page.dart';
import 'package:rehab_web/ui/new_patient/new_patient_page.dart';
import 'package:rehab_web/ui/patient/patient_page.dart';

import '../navigation_bar.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationBarController navigationBarController = Get.find();

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DashBoard(),
    );
  }
}
