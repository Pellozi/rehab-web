import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';
import 'package:rehab_web/ui/controller/doctor_controller.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/ui/home/dashboard.dart';
import 'package:rehab_web/ui/home/doctors_page.dart';
import 'package:rehab_web/ui/home/home_page.dart';
import 'package:rehab_web/ui/new_doctor/new_doctor_page.dart';
import 'package:rehab_web/ui/new_patient/new_patient_page.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
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
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 15.w,
              ),
              NavBarItem(
                title: MediaQuery.of(context).size.width < 982 ? '' : 'Inicio',
                icon: Icons.home,
                active: navigationBarController.index.value == 0,
                touched: () {
                  final PatientController patientController = Get.find();
                  setState(() {
                    navigationBarController.index.value = 0;
                    select(navigationBarController.index.value);
                  });

                  Get.to(DashBoard(), transition: Transition.fade);
                  patientController.getPatients();
                },
              ),
              NavBarItem(
                title: MediaQuery.of(context).size.width < 982 ? '' : 'Cadastrar paciente',
                icon: Icons.person_add,
                active: navigationBarController.index.value == 1,
                touched: () {
                  setState(() {
                    Get.to(NewPatientPage(), transition: Transition.fade);
                    navigationBarController.index.value = 1;
                    select(navigationBarController.index.value);
                  });
                },
              ),
              if (authController.user.value.master == 1)
                NavBarItem(
                  title: MediaQuery.of(context).size.width < 982 ? '' : 'Cadastrar funcionario',
                  icon: Icons.medical_services,
                  active: navigationBarController.index.value == 2,
                  touched: () {
                    setState(() {
                      navigationBarController.index.value = 2;
                      Get.to(NewDoctorPage(), transition: Transition.fade);
                      select(navigationBarController.index.value);
                    });
                  },
                ),
              if (authController.user.value.master == 1)
                NavBarItem(
                  title: MediaQuery.of(context).size.width < 982 ? '' : 'Gerenciar funcionarios',
                  icon: Icons.people_alt_sharp,
                  active: navigationBarController.index.value == 4,
                  touched: () {
                    final DoctorController doctorController = Get.put(DoctorController());
                    setState(() {
                      navigationBarController.index.value = 4;
                      select(navigationBarController.index.value);
                    });

                    Get.to(DoctorPage(), transition: Transition.fade);
                    doctorController.getDoctors();
                  },
                ),
            ],
          ),
        ));
  }
}
