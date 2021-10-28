import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/patient/patient_page.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PatientCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  final bool hasApp;
  PatientCard(
      {this.color, this.progressIndicatorColor, this.percentComplete, this.projectName, this.icon, this.hasApp = true});
  @override
  _PatientCardState createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  final NavigationBarController navigationBarController = Get.find();
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationBarController.index.value = 3;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        height: 225,
        width: 240,
        decoration: BoxDecoration(
            color: hovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                spreadRadius: 5.0,
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : widget.color,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: hovered ? Colors.white : RehabColors().mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Container(
                    child: Text(
                      widget.projectName,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 23.0,
                    width: 23.0,
                    child: Icon(
                      Icons.medical_services,
                      size: 23.0,
                      color: hovered ? Colors.white : RehabColors().mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Text(
                      'Cirurgia no coração',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 23.0,
                    width: 23.0,
                    child: Icon(
                      Feather.calendar,
                      size: 23.0,
                      color: hovered ? Colors.white : RehabColors().mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Text(
                      '15 de novembro, 2020',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 23.0,
                    width: 23.0,
                    child: Icon(
                      Icons.location_on,
                      size: 23.0,
                      color: hovered ? Colors.white : RehabColors().mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Text(
                      'Rua marechal deodoro',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.hasApp)
                Container(
                  margin: EdgeInsets.only(top: 8.0, left: 135.0),
                  child: Text(
                    widget.percentComplete,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                      color: hovered ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              if (widget.hasApp)
                AnimatedContainer(
                  duration: Duration(milliseconds: 275),
                  margin: EdgeInsets.only(top: 5.0),
                  height: 6.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                    color: hovered ? widget.progressIndicatorColor : Color(0xffF5F6FA),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 275),
                      height: 6.0,
                      width: widget.percentComplete == '100%'
                          ? (double.parse(widget.percentComplete.substring(0, 2)) / 10) * 160.0
                          : (double.parse(widget.percentComplete.substring(0, 1)) / 10) * 160.0,
                      decoration: BoxDecoration(
                        color: hovered ? Colors.white : widget.color,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              if (!widget.hasApp)
                Container(
                  margin: EdgeInsets.only(top: 8.0, right: 15),
                  child: Text(
                    'App não acessado ainda',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: hovered ? Colors.white : Color(0xffFF4C60),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
