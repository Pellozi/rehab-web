import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';

class NewPatientPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LargeChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      children: <Widget>[
        Text("Cadastro de paciente",
            style: GoogleFonts.quicksand(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          ),
        )
      ],
    );
  }
}
