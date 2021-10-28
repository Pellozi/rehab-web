import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';

import 'package:rehab_web/utils/responsive_layout.dart';

class NewPatientPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFFF8FBFF),
        Color(0xFFFCFDFD),
      ])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LargeChild(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      widthFactor: .7,
      child: Padding(
        padding: EdgeInsets.only(left: 580, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text("Cadastro de paciente",
                style: GoogleFonts.quicksand(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  TextFieldWidget('Nome'),
                  TextFieldWidget('Cpf'),
                  TextFieldWidget('Endereço'),
                  TextFieldWidget('Tipo de procedimento'),
                  TextFieldWidget('Tempo de reabilitação'),
                  SendBtn('Cadastrar')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
