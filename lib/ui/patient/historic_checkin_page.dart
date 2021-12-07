import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/ui/controller/care_controller.dart';
import 'package:rehab_web/ui/controller/checkin_controller.dart';
import 'package:rehab_web/utils/date_formatting.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

class SharedFilesItem extends StatefulWidget {
  final String sharedFileName;
  final Color color;
  final String members;
  final String et;
  final String fileSize;
  final IconData icon;

  SharedFilesItem({this.color, this.et, this.fileSize, this.members, this.sharedFileName, this.icon});

  @override
  _SharedFilesItemState createState() => _SharedFilesItemState();
}

class _SharedFilesItemState extends State<SharedFilesItem> {
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
                        widget.sharedFileName,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.members != null)
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                            widget.members,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      if (widget.members == null)
                        SizedBox(
                          width: 120,
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          widget.et,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          widget.fileSize,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedFilesItemIncident extends StatefulWidget {
  final Color color;
  final IncidentModel model;

  final IconData icon;

  SharedFilesItemIncident({this.color, this.model, this.icon});

  @override
  _SharedFilesItemIncidentState createState() => _SharedFilesItemIncidentState();
}

class _SharedFilesItemIncidentState extends State<SharedFilesItemIncident> {
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
                        width: 15.0.w,
                      ),
                      Container(
                        height: 38.0.w,
                        width: 38.0.w,
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
                        width: 18.0.w,
                      ),
                      Text(
                        'Incidente',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.model.incidente != null)
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                            widget.model.incidente,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0.w,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          dateAsStringLongMonth(DateTime.parse(widget.model.dtRelato)),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedFilesItemIncidentPressao extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentPressao({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Pressão arterial',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.pressao != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.pressao,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentFrequency extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentFrequency({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Frequencia cardíaca',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.freqCardiacaPre != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.freqCardiacaPre,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentSaturacao extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentSaturacao({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Saturação',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.saturacao != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.saturacao,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentTemp extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentTemp({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Temperatura',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.temperatura != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.temperatura,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentGlicemia extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentGlicemia({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Glicemia',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.glicemia != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.glicemia,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentBemEstar extends StatelessWidget {
  final Color color;
  final MonitoringModel model;
  final IconData icon;
  SharedFilesItemIncidentBemEstar({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Bem-estar',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.bemEstar != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.bemEstar.toString(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.data)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedFilesItemIncidentEsforco extends StatelessWidget {
  final Color color;
  final CareExerciseModel model;
  final IconData icon;
  SharedFilesItemIncidentEsforco({this.color, this.model, this.icon});
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
                      width: 15.0.w,
                    ),
                    Container(
                      height: 38.0.w,
                      width: 38.0.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: color,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0.w,
                    ),
                    Text(
                      'Esforço no exercicio: ${model.descricao}',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.w,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.perEsforco != null)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          model.perEsforco.toString(),
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0.w,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        dateAsStringLongMonth(DateTime.parse(model.dtPublicacao)),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.w,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
