import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:rehab_web/model/patient.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';
import 'package:rehab_web/ui/controller/care_controller.dart';
import 'package:rehab_web/ui/controller/checkin_controller.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/utils/chart.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'historic_checkin_page.dart';

class RegisterPatientPage extends StatefulWidget {
  @override
  _RegisterPatientPageState createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  TextEditingController textEditingEmailController = new TextEditingController();
  final NavigationBarController navigationBarController = Get.find();
  final CareController careController = Get.find();
  final CheckInController checkInController = Get.put(CheckInController());
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController cpfController = new TextEditingController(text: '');
  final TextEditingController eventController = new TextEditingController(text: '');
  final TextEditingController treatmentController = new TextEditingController(text: '');
  final TextEditingController dataController = new TextEditingController(text: '');
  final TextEditingController heightController = new MoneyMaskedTextController(decimalSeparator: '.', precision: 2);
  final PatientController patientController = Get.find();

  Future<void> init() async {
    await checkInController.getIncidents(navigationBarController.patient.value.cpf);
    await checkInController.getIMonitoring(navigationBarController.patient.value.cpf);
  }

  @override
  void initState() {
    print(navigationBarController.patient.value.cpf);
    init();
    super.initState();
  }

  List<DateTime> getDatesAsList() {
    List<DateTime> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(DateTime.parse(exerciseHistory.data));
    });
    return result;
  }

  List<double> getPressaoAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.pressao));
    });
    return result;
  }

  List<double> getBemAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.temperatura));
    });
    return result;
  }

  List<double> getGlicemiaAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.freqCardiacaPre));
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.w,
            ),
            if (navigationBarController.patient.value.habilitado)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 100.w, right: 100.w, bottom: 60.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 400,
                              width: 750,
                              child: DashboardChartWidget(
                                  values: [getPressaoAsList(), getBemAsList(), getGlicemiaAsList()],
                                  colors: [Colors.blue, Colors.red, Colors.lightGreenAccent],
                                  dates: getDatesAsList(),
                                  titles: ["Pressão arterial", "Temperatura", "Saturação"]),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Alert(
                                        context: context,
                                        title: "Edição do paciente",
                                        style: AlertStyle(
                                            titleTextAlign: TextAlign.center,
                                            titleStyle: TextStyle(
                                                color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
                                            buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.w)),
                                        content: StatefulBuilder(builder: (context, state) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller: nameController,
                                                  style: TextStyle(fontSize: 21.w),
                                                  decoration: InputDecoration(
                                                      icon: Icon(Icons.person),
                                                      labelText: 'Nome',
                                                      hintText: navigationBarController.patient.value.nome,
                                                      hintStyle: TextStyle(fontSize: 21.w)),
                                                ),
                                                TextField(
                                                  controller: eventController,
                                                  style: TextStyle(fontSize: 21.w),
                                                  decoration: InputDecoration(
                                                      icon: Icon(Icons.person),
                                                      labelText: 'Motivo do tratamento',
                                                      hintText: navigationBarController.patient.value.evento,
                                                      hintStyle: TextStyle(fontSize: 21.w)),
                                                ),
                                                TextField(
                                                  controller: treatmentController,
                                                  style: TextStyle(fontSize: 21.w),
                                                  decoration: InputDecoration(
                                                      icon: Icon(Icons.person),
                                                      labelText: 'Tipo de procedimento',
                                                      hintText: navigationBarController.patient.value.tratamento,
                                                      hintStyle: TextStyle(fontSize: 21.w)),
                                                ),
                                                TextField(
                                                    controller: dataController,
                                                    style: TextStyle(fontSize: 21.w),
                                                    decoration: InputDecoration(
                                                      icon: Icon(Icons.email),
                                                      labelText: 'Tempo de reabilitação',
                                                      hintText: navigationBarController.patient.value.nrDias.toString(),
                                                      labelStyle: TextStyle(fontSize: 21.w),
                                                      hintStyle: TextStyle(fontSize: 21.w),
                                                    )),
                                                TextField(
                                                    controller: heightController,
                                                    style: TextStyle(fontSize: 21.w),
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons.lock),
                                                        labelText: 'Altura',
                                                        hintText:
                                                            navigationBarController.patient.value.altura.toString(),
                                                        labelStyle: TextStyle(fontSize: 21.w),
                                                        hintStyle: TextStyle(fontSize: 21.w))),
                                              ],
                                            ),
                                          );
                                        }),
                                        buttons: [
                                          DialogButton(
                                            onPressed: () async {
                                              final AuthController authController = Get.find();
                                              await patientController.createPatient(PatientResponse((b) => b
                                                ..cpf = navigationBarController.patient.value.cpf
                                                ..email = navigationBarController.patient.value.email
                                                ..nome = nameController.text == ''
                                                    ? navigationBarController.patient.value.nome
                                                    : nameController.text
                                                ..altura = heightController.text == '0.00'
                                                    ? navigationBarController.patient.value.altura
                                                    : double.tryParse(
                                                        double.tryParse(heightController.text).toStringAsFixed(2))
                                                ..evento = eventController.text == ''
                                                    ? navigationBarController.patient.value.evento
                                                    : eventController.text
                                                ..tratamento = treatmentController.text == ''
                                                    ? navigationBarController.patient.value.tratamento
                                                    : treatmentController.text
                                                ..password = navigationBarController.patient.value.password
                                                ..fumante = false
                                                ..respCadastro = authController.user.value.cpf
                                                ..diabetico = false
                                                ..habilitado = navigationBarController.patient.value.habilitado
                                                ..nrDias = dataController.text == ''
                                                    ? navigationBarController.patient.value.nrDias
                                                    : int.tryParse(dataController.text)));
                                              Get.back();
                                              if (patientController.status.isSuccess) {
                                                await patientController.getPatients();
                                                navigationBarController.patient.value = patientController.listPatient
                                                    .firstWhere((element) =>
                                                        element.cpf == navigationBarController.patient.value.cpf);
                                                Get.snackbar('Sucesso', 'Paciente editado!',
                                                    colorText: Colors.white,
                                                    backgroundColor: RehabColors().mainColor,
                                                    margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                                                    snackPosition: SnackPosition.TOP);
                                              }
                                            },
                                            child: Text(
                                              "Editar",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            color: RehabColors().mainColor,
                                          ),
                                        ]).show();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)
                                        ],
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                navigationBarController.patient.value.nome,
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
                                                navigationBarController.patient.value.tratamento,
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
                                                navigationBarController.patient.value.evento,
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
                                              boxShadow: [
                                                BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)
                                              ],
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
                                                  Icons.edit,
                                                  size: 23.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Container(
                                                child: Text(
                                                  'Editar',
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
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.incidents.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncident(
                                    icon: Icons.warning_amber_outlined,
                                    color: Colors.red[800],
                                    model: checkInController.incidents[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.pressao.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentPressao(
                                    icon: Icons.fact_check,
                                    color: Colors.blue,
                                    model: checkInController.pressao[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.freqCardiacaPre.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentFrequency(
                                    icon: Icons.fact_check,
                                    color: Colors.blue,
                                    model: checkInController.freqCardiacaPre[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.saturacao.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentSaturacao(
                                    icon: Icons.fact_check,
                                    color: Colors.blue,
                                    model: checkInController.freqCardiacaPre[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.temperatura.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentTemp(
                                    icon: Icons.fact_check,
                                    color: Colors.blue,
                                    model: checkInController.freqCardiacaPre[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.glicemia.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentBemEstar(
                                    icon: Icons.fact_check,
                                    color: Colors.lightGreenAccent,
                                    model: checkInController.freqCardiacaPre[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkInController.bemEstar.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentGlicemia(
                                    icon: Icons.fact_check,
                                    color: Colors.orangeAccent,
                                    model: checkInController.freqCardiacaPre[index]);
                              },
                            )),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: careController.listExerciseEsforco.length,
                              itemBuilder: (context, index) {
                                return SharedFilesItemIncidentEsforco(
                                    icon: Icons.fact_check,
                                    color: Colors.lime,
                                    model: careController.listExerciseEsforco[index]);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            if (!navigationBarController.patient.value.habilitado)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.w, horizontal: 350.w),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Alert(
                            context: context,
                            title: "Edição do paciente",
                            style: AlertStyle(
                                titleTextAlign: TextAlign.center,
                                titleStyle:
                                    TextStyle(color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
                                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.w)),
                            content: StatefulBuilder(builder: (context, state) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      style: TextStyle(fontSize: 21.w),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          labelText: 'Nome',
                                          hintText: navigationBarController.patient.value.nome,
                                          hintStyle: TextStyle(fontSize: 21.w)),
                                    ),
                                    TextField(
                                      controller: eventController,
                                      style: TextStyle(fontSize: 21.w),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          labelText: 'Motivo do tratamento',
                                          hintText: navigationBarController.patient.value.evento,
                                          hintStyle: TextStyle(fontSize: 21.w)),
                                    ),
                                    TextField(
                                      controller: treatmentController,
                                      style: TextStyle(fontSize: 21.w),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          labelText: 'Tipo de procedimento',
                                          hintText: navigationBarController.patient.value.tratamento,
                                          hintStyle: TextStyle(fontSize: 21.w)),
                                    ),
                                    TextField(
                                        controller: dataController,
                                        style: TextStyle(fontSize: 21.w),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email),
                                          labelText: 'Tempo de reabilitação',
                                          hintText: navigationBarController.patient.value.nrDias.toString(),
                                          labelStyle: TextStyle(fontSize: 21.w),
                                          hintStyle: TextStyle(fontSize: 21.w),
                                        )),
                                    TextField(
                                        controller: heightController,
                                        style: TextStyle(fontSize: 21.w),
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.lock),
                                            labelText: 'Altura',
                                            hintText: navigationBarController.patient.value.altura.toString(),
                                            labelStyle: TextStyle(fontSize: 21.w),
                                            hintStyle: TextStyle(fontSize: 21.w))),
                                  ],
                                ),
                              );
                            }),
                            buttons: [
                              DialogButton(
                                onPressed: () async {
                                  final NavigationBarController navigationBarController = Get.find();
                                  final AuthController authController = Get.find();
                                  await patientController.createPatient(PatientResponse((b) => b
                                    ..cpf = navigationBarController.patient.value.cpf
                                    ..email = navigationBarController.patient.value.email
                                    ..nome = nameController.text == ''
                                        ? navigationBarController.patient.value.nome
                                        : nameController.text
                                    ..altura = heightController.text == '0.00'
                                        ? navigationBarController.patient.value.altura
                                        : double.tryParse(double.tryParse(heightController.text).toStringAsFixed(2))
                                    ..evento = eventController.text == ''
                                        ? navigationBarController.patient.value.evento
                                        : eventController.text
                                    ..tratamento = treatmentController.text == ''
                                        ? navigationBarController.patient.value.tratamento
                                        : treatmentController.text
                                    ..password = navigationBarController.patient.value.password
                                    ..fumante = false
                                    ..respCadastro = authController.user.value.cpf
                                    ..diabetico = false
                                    ..habilitado = navigationBarController.patient.value.habilitado
                                    ..nrDias = dataController.text == ''
                                        ? navigationBarController.patient.value.nrDias
                                        : int.tryParse(dataController.text)));
                                  Get.back();
                                  if (patientController.status.isSuccess) {
                                    await patientController.getPatients();
                                    navigationBarController.patient.value = patientController.listPatient.firstWhere(
                                        (element) => element.cpf == navigationBarController.patient.value.cpf);
                                    Get.snackbar('Sucesso', 'Paciente editado!',
                                        colorText: Colors.white,
                                        backgroundColor: RehabColors().mainColor,
                                        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                                        snackPosition: SnackPosition.TOP);
                                    navigationBarController.index.value = 0;
                                  }
                                },
                                child: Text(
                                  "Editar",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                color: RehabColors().mainColor,
                              ),
                            ]).show();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    navigationBarController.patient.value.nome,
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
                                    navigationBarController.patient.value.tratamento,
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
                                    navigationBarController.patient.value.evento,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 18.0,
                                  ),
                                  Container(
                                    height: 23.0,
                                    width: 23.0,
                                    child: Icon(
                                      Icons.edit,
                                      size: 23.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    child: Text(
                                      'Editar',
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
                    ),
                    SizedBox(
                      height: 50.w,
                    ),
                    Text(
                      'Envie o aplicativo para o paciente clicando no botão abaixo',
                      maxLines: 4,
                      style: TextStyle(fontSize: 32.w, color: RehabColors().grayColor),
                    ),
                    SizedBox(
                      height: 50.w,
                    ),
                    InkWell(
                      onTap: () {
                        Alert(
                            context: context,
                            title: "Informe o email do paciente",
                            style: AlertStyle(
                                titleTextAlign: TextAlign.center,
                                titleStyle: TextStyle(color: Colors.black54, fontSize: 22),
                                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  controller: textEditingEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.email_outlined),
                                    labelText: 'Email',
                                  ),
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () async {
                                  await emailTo();
                                  Get.back();
                                  Get.snackbar('Sucesso', 'O aplicativo foi enviado no email informado!',
                                      colorText: Colors.white,
                                      backgroundColor: RehabColors().mainColor,
                                      margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                                      snackPosition: SnackPosition.TOP);
                                },
                                child: Text(
                                  "Salvar",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                color: RehabColors().mainColor,
                              )
                            ]).show();
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Icon(
                              Icons.send,
                              size: 35,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }

  Future<void> emailTo() async {
    final mailto = Mailto(
      to: [
        textEditingEmailController.text,
      ],
      subject: 'Aplicativo Rehab.it',
      body:
          'Olá, Tudo bem?\n\nSegue o link do aplicativo para voce acompanhar a sua reabilitação\n\n\n\n https://drive.google.com/drive/folders/11byU6BWT_ZS94t0hhX6VQCCM10-RG_Zt?usp=sharing',
    );

    try {
      await launch('$mailto');
    } catch (error) {
      print(error);
    }
  }
}
