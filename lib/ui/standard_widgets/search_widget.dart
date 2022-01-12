import 'package:flutter/material.dart';
import 'package:rehab_web/utils/colors.dart';

import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_web/utils/responsive_layout.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final hasPassWord;
  bool hasPadding;
  bool hasAllPadding;
  final double fontSize;
  final bool isSearchField;
  final String labelTitle;
  final TextEditingController controller;
  final Function onTap;
  TextFieldWidget(this.label, this.controller,
      {this.hasPassWord = false,
      this.hasPadding = true,
      this.fontSize = 18,
      this.labelTitle = '',
      this.isSearchField = false,
      this.hasAllPadding = true,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasAllPadding
          ? EdgeInsets.only(
              left: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
              right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
              top: 10.w,
              bottom: hasPadding ? 25.w : 0,
            )
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 7.w, left: 10.w),
              child: Text(
                labelTitle,
                style: TextStyle(fontSize: 14.w),
              ),
            ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (isSearchField) ...[
                    Icon(
                      Icons.search,
                      size: 32.w,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: hasPassWord,
                      style: TextStyle(fontSize: fontSize.w),
                      decoration: InputDecoration(border: InputBorder.none, hintText: label),
                    ),
                  ),
                  if (isSearchField) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            padding: EdgeInsets.all(15.w),
                            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.w),
                            decoration: BoxDecoration(
                                color: RehabColors().mainColor, borderRadius: BorderRadius.circular(40.w)),
                            child: Text(
                              'Pesquisar',
                              style: TextStyle(color: Colors.white, fontSize: 18.w),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
