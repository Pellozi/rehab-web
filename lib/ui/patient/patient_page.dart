import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/patient/nutritional_page.dart';
import 'package:rehab_web/ui/patient/register_patient_page.dart';
import 'package:rehab_web/ui/patient/workout_page.dart';
import 'package:rehab_web/utils/colors.dart';

import 'general_care_page.dart';
import 'medicines_page.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  PageController _pageController;
  var _pageIndex = 0; //d

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          header(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              pageSnapping: false,
              onPageChanged: (index) {
                setState(() => _pageIndex = index);
              },
              children: [RegisterPatientPage(), MedicinesPage(), GeneralCarePage(), NutritionalPage(), WorkoutPage()],
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(top: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 0;
                    _pageController.jumpToPage(0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 0 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Regristro do paciente',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 0 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(width: 50),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 1;
                    _pageController.jumpToPage(1);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 1 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Medicamentos',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 1 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 2;
                    _pageController.jumpToPage(2);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 2 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Cuidados Gerais',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 2 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 3;
                    _pageController.jumpToPage(3);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 3 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Dieta e nutrição',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 3 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 4;
                    _pageController.jumpToPage(4);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 4 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Atividades físicas',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 4 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
