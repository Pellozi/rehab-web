import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/home/doctors_page.dart';
import 'package:rehab_web/ui/new_doctor/new_doctor_page.dart';
import 'package:rehab_web/ui/new_patient/new_patient_page.dart';
import 'package:rehab_web/ui/patient/patient_page.dart';

import '../navigation_bar.dart';
import 'dashboard.dart';

class HomePage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Row(
              children: [
                NavigationBar(),
                if (navigationBarController.index.value == 0) DashBoard(),
                if (navigationBarController.index.value == 1) Expanded(child: NewPatientPage()),
                if (navigationBarController.index.value == 2 && navigationBarController.password.value == 'asd123')
                  Expanded(child: NewDoctorPage()),
                if (navigationBarController.index.value == 3) Expanded(child: PatientPage()),
                if (navigationBarController.index.value == 4 && navigationBarController.password.value == 'asd123')
                  Expanded(child: DoctorPage()),
              ],
            ),
          )),
    );
  }
}
