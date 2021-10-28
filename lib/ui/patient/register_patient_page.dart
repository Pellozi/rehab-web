import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/utils/chart.dart';
import 'package:rehab_web/utils/colors.dart';

import 'historic_checkin_page.dart';

class RegisterPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 100, right: 100, bottom: 60),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 400,
                        width: 750,
                        child: DashboardChartWidget(values: [
                          [5, 12, 3],
                          [100, 110, 250],
                          [3, 7, 10]
                        ], colors: [
                          Colors.blue,
                          Colors.red,
                          Colors.lightGreenAccent
                        ], dates: [
                          DateTime.now(),
                          DateTime.now(),
                          DateTime.now()
                        ], titles: [
                          "pressão",
                          "glicose",
                          "bem-estar"
                        ]),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Manoel Pereira',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0,
                                      color: Color(0xFF8591B0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  child: Text(
                                    'Cirurgia no coração',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0,
                                      color: Color(0xFF8591B0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  child: Text(
                                    'Rua marechal deodoro',
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0,
                                      color: Color(0xFF8591B0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: RehabColors().mainColor,
                                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)],
                                  borderRadius: BorderRadius.circular(40)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 18.0,
                                  ),
                                  Container(
                                    height: 23.0,
                                    width: 23.0,
                                    child: Icon(
                                      Icons.chat,
                                      size: 23.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Chat',
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Enviar app para o paciente',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Icon(
                              Icons.send,
                              size: 35,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SharedFilesItem(
                    icon: Icons.warning_amber_outlined,
                    color: Colors.red[800],
                    sharedFileName: 'Incidente',
                    members: 'Os pontos romperam quando fui lavar o curativo',
                    et: '08 Jun 2021',
                    fileSize: '1',
                  ),
                  SharedFilesItem(
                    icon: Icons.fact_check,
                    color: Colors.blue,
                    sharedFileName: 'pressão',
                    et: '08 Jun 2021',
                    fileSize: '10/12',
                  ),
                  SharedFilesItem(
                    icon: Icons.fact_check,
                    color: Colors.lightGreenAccent,
                    sharedFileName: 'Bem-estar',
                    et: '08 Jun 2021',
                    fileSize: '10',
                  ),
                  SharedFilesItem(
                    icon: Icons.fact_check,
                    color: Colors.red,
                    sharedFileName: 'Glicose',
                    et: '08 Jun 2021',
                    fileSize: '100',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
