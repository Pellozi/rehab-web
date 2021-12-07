import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/ui/home/patient_card.dart';
import 'package:rehab_web/ui/standard_widgets/obx_widget.dart';
import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/utils/date_formatting.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../navigation_bar.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController searchController = TextEditingController();
  final PatientController patientController = Get.put(PatientController());
  @override
  void initState() {
    //patientController.getPatients();
    initializeDateFormatting("pt_BR", null);
    timeago.setLocaleMessages('pt_br_short', PtBrShortMessagesModified());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: RehabObxWidget(
          patientController,
          Column(
            children: [
              NavigationBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    color: Color(0xFFF8FBFF),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        TextFieldWidget(
                          'Pesquisar paciente',
                          searchController,
                          isSearchField: true,
                          onTap: () async {
                            patientController.startLoading();
                            if (searchController.text != '' &&
                                patientController.listPatient
                                    .any((p0) => p0.nome.contains(searchController.text.removeAllWhitespace))) {
                              patientController.listPatient.value = patientController.listPatient
                                  .where((p0) => p0.nome.contains(searchController.text.removeAllWhitespace))
                                  .toList();
                              patientController.finishLoading();
                              return;
                            }
                            await patientController.getPatients();
                            patientController.finishLoading();
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Obx(
                              () => GridView.count(
                                crossAxisCount: crossAxisCount(context),
                                shrinkWrap: true,
                                crossAxisSpacing: 0.w,
                                mainAxisSpacing: 25.w,
                                childAspectRatio: MediaQuery.of(context).size.width < 598 ? 6 / 3 : 2.8 / 2,
                                children: List.generate(
                                  patientController.listPatient.length,
                                  (index) => PatientCard(
                                    color: Color(0xff6C6CE5),
                                    treatment: patientController.listPatient[index].tratamento,
                                    projectName: patientController.listPatient[index].nome,
                                    date: patientController.listPatient[index].dtInicio.isNotEmpty
                                        ? DateTime.parse(patientController.listPatient[index].dtInicio)
                                        : DateTime.now(),
                                    percentComplete: '10%',
                                    model: patientController.listPatient[index],
                                    progressIndicatorColor: Colors.amber[200],
                                    icon: Icons.person,
                                    daysRehab: patientController.listPatient[index].nrDias,
                                    hasApp: patientController.listPatient[index].habilitado,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  int crossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width < 598) return 1;
    if (MediaQuery.of(context).size.width < 860) return 2;
    if (MediaQuery.of(context).size.width < 1122) return 3;

    if (MediaQuery.of(context).size.width > 1550) return 6;
    if (MediaQuery.of(context).size.width < 1386 && MediaQuery.of(context).size.width > 1121) return 4;

    return 5;
  }
}
