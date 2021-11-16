import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/model/user.dart';
import 'package:rehab_web/ui/controller/doctor_controller.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';
import 'package:rehab_web/ui/home/doctors_page.dart';
import 'package:rehab_web/ui/standard_widgets/obx_widget.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_web/utils/responsive_layout.dart';

import '../navigation_bar.dart';

class NewDoctorPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  final DoctorController doctorController = Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        doctorController,
        Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              NavigationBar(),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: widthContainer(context), vertical: 25),
                children: [
                  Text("Cadastro de especialista",
                      style:
                          GoogleFonts.quicksand(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                  SizedBox(
                    height: 25,
                  ),
                  LargeChild(),
                ],
              ),
            ],
          ),
        ));
  }

  double widthContainer(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1200) return 100.w;
    if (MediaQuery.of(context).size.width < 1400) return 250.w;
    if (MediaQuery.of(context).size.width < 1538) return 350.w;

    return 500.w;
  }
}

class LargeChild extends StatefulWidget {
  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return RehabColors().mainColor;
    }
    return Color(0xFF8591B0);
  }

  final NavigationBarController navigationBarController = Get.find();
  final DoctorController doctorController = Get.find();
  bool isCheckedNutritional = false;
  bool isCheckedMedicines = false;
  bool isCheckedWorkout = false;
  bool isCheckedAddNewDoctor = false;
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController cpfController = new TextEditingController(text: '');
  final TextEditingController passwordController = new TextEditingController(text: '');
  final TextEditingController typeController = new TextEditingController(text: '');
  final TextEditingController emailController = new TextEditingController(text: '');
  List<DropdownMenuItem<String>> _dropDownMenu = new List<DropdownMenuItem<String>>();
  String _selected;
  @override
  void initState() {
    setState(() {
      _dropDownMenu.add(new DropdownMenuItem<String>(
          value: 'nutricionista',
          child: new Text(
            'Nutricionista ',
            style: TextStyle(color: Colors.black, fontSize: 18.w),
          )));
      _dropDownMenu.add(new DropdownMenuItem<String>(
          value: 'edFisico',
          child: new Text('Educador físico', style: TextStyle(color: Colors.black, fontSize: 18.w))));
      _dropDownMenu.add(new DropdownMenuItem<String>(
          value: 'medico', child: new Text('Médico', style: TextStyle(color: Colors.black, fontSize: 18.w))));
      _dropDownMenu.add(new DropdownMenuItem<String>(
          value: 'enfermeiro', child: new Text('Enfermeiro', style: TextStyle(color: Colors.black, fontSize: 18.w))));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.w),
      decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: TextFieldWidget(
                          'Nome',
                          nameController,
                          hasAllPadding: false,
                          labelTitle: 'Nome',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: TextFieldWidget(
                          'Cpf',
                          cpfController,
                          hasAllPadding: false,
                          labelTitle: 'Cpf',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: TextFieldWidget(
                          'Email',
                          emailController,
                          hasAllPadding: false,
                          labelTitle: 'Email',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: TextFieldWidget(
                          'Senha',
                          passwordController,
                          hasAllPadding: false,
                          labelTitle: 'Senha',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 7.w, left: 45.w, top: 20.w),
                        child: Text(
                          'Tipo de especialista',
                          style: TextStyle(fontSize: 14.w),
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.all(20.w),
                        margin: EdgeInsets.only(left: 45.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
                        child: DropdownButton(
                            icon: Icon(
                              Icons.edit,
                              size: 15.w,
                              color: RehabColors().grayColor,
                            ),
                            hint: Text(
                              'Tipo de especialista',
                              style: TextStyle(fontSize: 18.w, color: Colors.black38),
                            ),
                            style: TextStyle(fontSize: 12.w),
                            iconEnabledColor: Colors.black87,
                            underline: Container(),
                            isExpanded: true,
                            isDense: true,
                            value: _selected,
                            items: _dropDownMenu,
                            onChanged: (value) {
                              setState(() {
                                _selected = value;
                              });
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w, top: 35.w),
                        child: Text("Marque as permissões que o especialista irá ter no sitema:",
                            style: GoogleFonts.notoSans(
                                fontSize: 21.w, fontWeight: FontWeight.bold, color: Colors.black54)),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isCheckedMedicines,
                              onChanged: (bool value) {
                                setState(() {
                                  isCheckedMedicines = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("Medicamentos",
                                style: GoogleFonts.notoSans(
                                    fontSize: 20.w, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isCheckedAddNewDoctor,
                              onChanged: (bool value) {
                                setState(() {
                                  isCheckedAddNewDoctor = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("Cadastrar novo paciente",
                                style: GoogleFonts.notoSans(
                                    fontSize: 20.w, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isCheckedNutritional,
                              onChanged: (bool value) {
                                setState(() {
                                  isCheckedNutritional = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("Dietas e nutrição",
                                style: GoogleFonts.notoSans(
                                    fontSize: 20.w, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isCheckedWorkout,
                              onChanged: (bool value) {
                                setState(() {
                                  isCheckedWorkout = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("Atividade física",
                                style: GoogleFonts.notoSans(
                                    fontSize: 20.w, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.w),
              child: SendBtn(
                'Cadastrar',
                fontSize: 18.w,
                hasPaddingVertical: false,
                hasPadding: false,
                width: 200.w,
                onTap: () async {
                  final NavigationBarController navigationBarController = Get.find();
                  await doctorController.createDoctor(User((b) => b
                    ..cpf = cpfController.text
                    ..email = emailController.text
                    ..nome = nameController.text
                    ..master = 0
                    ..password = passwordController.text
                    ..cdDieta = isCheckedNutritional ? 1 : 0
                    ..cdExercicio = isCheckedWorkout ? 1 : 0
                    ..cdMedicamento = isCheckedMedicines ? 1 : 0
                    ..cdPaciente = isCheckedAddNewDoctor ? 1 : 0
                    ..tpEspecialista = _selected));
                  if (doctorController.status.isSuccess) {
                    await doctorController.getDoctors();
                    Get.snackbar('Sucesso', 'Novo especialista cadastrado!',
                        colorText: Colors.white,
                        backgroundColor: RehabColors().mainColor,
                        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                        snackPosition: SnackPosition.TOP);
                    navigationBarController.index.value = 4;
                    Get.to(DoctorPage(), transition: Transition.fade);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
