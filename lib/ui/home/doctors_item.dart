import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/data/datas.dart';

class DoctorItem extends StatefulWidget {
  final Item doctor;
  final Color color;
  final IconData icon;
  final Animation animation;
  final VoidCallback onClicked;
  final VoidCallback onClickItem;
  DoctorItem(
    this.doctor, {
    this.color,
    this.icon,
    this.animation,
    this.onClicked,
    this.onClickItem,
  });

  @override
  _DoctorItemState createState() => _DoctorItemState();
}

class _DoctorItemState extends State<DoctorItem> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onClickItem,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 275),
          margin: EdgeInsets.only(bottom: 10.0, right: 15.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: hovered
                  ? [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 13.0,
                        spreadRadius: 0.0,
                      ),
                    ]
                  : []),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          height: 38.0,
                          width: 38.0,
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              color: widget.color,
                              size: 25.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          widget.doctor.description,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red, size: 32),
                      onPressed: widget.onClicked,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
