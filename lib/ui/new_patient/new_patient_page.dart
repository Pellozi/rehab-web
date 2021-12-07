import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rehab_web/model/patient.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/ui/home/dashboard.dart';
import 'package:rehab_web/ui/standard_widgets/obx_widget.dart';
import 'package:rehab_web/utils/colors.dart';

import 'package:rehab_web/utils/date_formatting.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../navigation_bar.dart';

class NewPatientPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  final PatientController patientController = Get.put(PatientController());
  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        patientController,
        Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              NavigationBar(),
              LargeChild(),
            ],
          ),
        ));
  }
}

class LargeChild extends StatefulWidget {
  @override
  State<LargeChild> createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController cpfController = new TextEditingController(text: '');
  final TextEditingController eventController = new TextEditingController(text: '');
  final TextEditingController treatmentController = new TextEditingController(text: '');
  final TextEditingController dataController = new TextEditingController(text: '');
  final TextEditingController heightController = new MoneyMaskedTextController(decimalSeparator: '.', precision: 2);
  final PatientController patientController = Get.find();
  String birthDate;
  DateTime startDate = DateTime.now();
  @override
  void initState() {
    initializeDateFormatting("pt_BR", null);
    timeago.setLocaleMessages('pt_br_short', PtBrShortMessagesModified());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: widthContainer(context), vertical: 25.w),
      children: <Widget>[
        Text("Cadastro de paciente",
            style: GoogleFonts.quicksand(fontSize: 35.w, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.only(top: 20.w),
          decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget('Nome', nameController,
                      hasAllPadding: false,
                      fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                      labelTitle: 'Nome'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget(
                    'Cpf',
                    cpfController,
                    fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                    labelTitle: 'Cpf',
                    hasAllPadding: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget(
                    'Altura',
                    heightController,
                    fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                    labelTitle: 'Altura',
                    hasAllPadding: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget('Motivo do tratamento', eventController,
                      fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                      labelTitle: 'Motivo do tratamento',
                      hasAllPadding: false),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget('Tipo de procedimento', treatmentController,
                      fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                      labelTitle: 'Tipo de procedimento',
                      hasAllPadding: false),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: TextFieldWidget('Tempo de reabilitação', dataController,
                      hasPadding: false,
                      fontSize: MediaQuery.of(context).size.width > 1537 ? 22.w : 18.w,
                      labelTitle: 'Tempo de reabilitação(dias)',
                      hasAllPadding: false),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.w),
                      child: SendBtn(
                        'Cadastrar',
                        onTap: () async {
                          final NavigationBarController navigationBarController = Get.find();
                          final AuthController authController = Get.find();
                          await patientController.createPatient(PatientResponse((b) => b
                            ..cpf = cpfController.text
                            ..email = '${nameController.text}@email.com'
                            ..nome = nameController.text
                            ..altura = double.tryParse(double.tryParse(heightController.text).toStringAsFixed(2))
                            ..evento = eventController.text
                            ..tratamento = treatmentController.text
                            ..password = cpfController.text
                            ..fumante = false
                            ..respCadastro = authController.user.value.cpf
                            ..diabetico = false
                            ..nrDias = int.tryParse(dataController.text)));
                          if (patientController.status.isSuccess) {
                            await patientController.getPatients();
                            Get.snackbar('Sucesso', 'Paciente cadastrado!',
                                colorText: Colors.white,
                                backgroundColor: RehabColors().mainColor,
                                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                                snackPosition: SnackPosition.TOP);
                            navigationBarController.index.value = 0;
                            Get.to(DashBoard(), transition: Transition.fade);
                          }
                        },
                        fontSize: 18.w,
                        hasPaddingVertical: false,
                        hasPadding: false,
                        width: 200.w,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  double widthContainer(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1200) return 100.w;
    if (MediaQuery.of(context).size.width < 1400) return 250.w;
    if (MediaQuery.of(context).size.width < 1538) return 350.w;

    return 500.w;
  }
}
