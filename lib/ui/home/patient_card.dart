import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/ui/patient/patient_page.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/date_formatting.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

class PatientCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  final bool hasApp;
  final String treatment;
  final DateTime date;
  final int daysRehab;
  final PatientModel model;
  PatientCard(
      {this.color,
      this.progressIndicatorColor,
      this.percentComplete,
      this.projectName,
      this.icon,
      this.hasApp = true,
      this.treatment,
      this.date,
      this.daysRehab,
      this.model});
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
        navigationBarController.patient.value = widget.model;
        navigationBarController.index.value = 3;
        Get.to(PatientPage());
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        margin: EdgeInsets.all(20.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0), boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 3.0,
          ),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30.0.w,
                  width: 30.0.w,
                  child: Icon(
                    widget.icon,
                    color: !hovered ? Colors.white : widget.color,
                    size: 18.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0.w),
                    color: hovered ? Colors.white : RehabColors().mainColor,
                  ),
                ),
                SizedBox(
                  width: 13.0.w,
                ),
                Container(
                  child: Text(
                    widget.projectName,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0.w,
                      color: hovered ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.medical_services,
                  size: 23.0.w,
                  color: hovered ? Colors.white : RehabColors().mainColor,
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                Text(
                  widget.treatment,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0.w,
                    color: hovered ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 23.0.w,
                  width: 23.0.w,
                  child: Icon(
                    Feather.calendar,
                    size: 23.0.w,
                    color: hovered ? Colors.white : RehabColors().mainColor,
                  ),
                ),
                SizedBox(
                  width: 8.0.w,
                ),
                Container(
                  child: Text(
                    dataParse(widget.date),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0.w,
                      color: hovered ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0.w,
            ),
            if (widget.hasApp)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.percentComplete,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5.w,
                    color: hovered ? Colors.white : Colors.black,
                  ),
                ),
              ),
            if (widget.hasApp)
              AnimatedContainer(
                duration: Duration(milliseconds: 275),
                margin: EdgeInsets.only(top: 5.0.w),
                height: 6.0.w,
                width: 170.0.w,
                decoration: BoxDecoration(
                  color: hovered ? widget.progressIndicatorColor : Color(0xffF5F6FA),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 275),
                    height: 6.0.w,
                    width: widget.percentComplete == '100%'
                        ? (double.parse(widget.percentComplete.substring(0, 2)) / 10) * 170.0.w
                        : (1 / 10) * 170.0.w,
                    decoration: BoxDecoration(
                      color: hovered ? Colors.white : widget.color,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            if (!widget.hasApp)
              Container(
                margin: EdgeInsets.only(top: 5.0.w, right: 15.w),
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
    );
  }

  String dataParse(DateTime dateTime) {
    return dateAsStringLongMonth(dateTime);
  }

  int difference() {
    final date2 = DateTime.now();
    var reot = widget.date.difference(DateTime.now()).inDays;
    return reot;
  }
}
