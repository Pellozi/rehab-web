import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/home/home_page.dart';

import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

import 'package:rehab_web/utils/responsive_layout.dart';

class SendBtn extends StatelessWidget {
  final String label;
  final bool hasPadding;
  final double width;
  final double fontSize;
  final Function onTap;
  final bool hasPaddingVertical;
  Color buttonColor;
  SendBtn(this.label,
      {this.hasPadding = true,
      this.onTap,
      this.width,
      this.fontSize,
      this.hasPaddingVertical = true,
      this.buttonColor = const Color(0xFF20ADBD)});
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
                left: ResponsiveLayout.isSmallScreen(context) ? 4 : 74.w,
                right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74.w,
                top: hasPaddingVertical ? 50.w : 0,
                bottom: hasPaddingVertical ? 50.w : 0,
              )
            : EdgeInsets.zero,
        child: Container(
          height: 60.w,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      color: Colors.white, fontSize: fontSize ?? 30.w, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
