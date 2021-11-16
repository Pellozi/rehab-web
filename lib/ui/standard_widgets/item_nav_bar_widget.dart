import 'package:flutter/material.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final bool active;
  final String title;
  NavBarItem({this.icon, this.touched, this.active, this.title});
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print(widget.icon);
          widget.touched();
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Icon(
                        widget.icon,
                        color: widget.active ? Colors.white : Colors.white54,
                        size: 20.0.w,
                      ),
                    ),
                    Text(
                      widget.title ?? '',
                      style: TextStyle(color: widget.active ? Colors.white : Colors.white54, fontSize: 20.w),
                    ),
                    SizedBox(
                      width: 30.w,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
