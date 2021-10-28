import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/home/home_page.dart';

import 'package:rehab_web/utils/colors.dart';

import 'package:rehab_web/utils/responsive_layout.dart';

class SendBtn extends StatelessWidget {
  final String label;
  final bool hasPadding;
  final Function onTap;
  SendBtn(this.label, {this.hasPadding = true, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Get.to(HomePage());
          },
      child: Padding(
        padding: hasPadding
            ? EdgeInsets.only(
                left: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
                right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
                top: 50,
                bottom: 50,
              )
            : EdgeInsets.zero,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: RehabColors().mainColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
