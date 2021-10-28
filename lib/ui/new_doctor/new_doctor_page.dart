import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';
import 'package:rehab_web/utils/colors.dart';

import 'package:rehab_web/utils/responsive_layout.dart';

class NewDoctorPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
        children: [
          Text("Cadastro de especialista",
              style: GoogleFonts.quicksand(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
          SizedBox(
            height: 25,
          ),
          LargeChild(),
        ],
      ),
    );
  }
}

class LargeChild extends StatefulWidget {
  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return RehabColors().mainColor;
    }
    return Color(0xFF8591B0);
  }

  final NavigationBarController navigationBarController = Get.find();
  bool isCheckedNutritional = false;
  bool isCheckedMedicines = false;
  bool isCheckedWorkout = false;
  bool isCheckedAddNewDoctor = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFieldWidget('Nome'),
            TextFieldWidget('Cpf'),
            TextFieldWidget('Email'),
            TextFieldWidget('Senha'),
            TextFieldWidget('Tipo de especialista'),
            Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text("Marque as permissões que o especialista irá ter no sitema:",
                  style: GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isCheckedMedicines,
                    onChanged: (bool value) {
                      setState(() {
                        isCheckedMedicines = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Medicamentos",
                      style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isCheckedAddNewDoctor,
                    onChanged: (bool value) {
                      setState(() {
                        isCheckedAddNewDoctor = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Cadastrar novo paciente",
                      style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isCheckedNutritional,
                    onChanged: (bool value) {
                      setState(() {
                        isCheckedNutritional = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Dietas e nutrição",
                      style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isCheckedWorkout,
                    onChanged: (bool value) {
                      setState(() {
                        isCheckedWorkout = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Atividade física",
                      style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                ],
              ),
            ),
            SendBtn(
              'Cadastrar',
              onTap: () {
                navigationBarController.doctors.insert(0, new Item('Andressa', value: 'Enfermeira'));
                navigationBarController.index.value = 4;
              },
            )
          ],
        ),
      ),
    );
  }
}
