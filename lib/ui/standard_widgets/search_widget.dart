import 'package:flutter/material.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';

import 'package:rehab_web/utils/responsive_layout.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final hasPassWord;
  TextFieldWidget(this.label, {this.hasPassWord = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
        right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
        top: 10,
        bottom: 25,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: TextField(
                    obscureText: hasPassWord,
                    decoration: InputDecoration(border: InputBorder.none, hintText: label),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
