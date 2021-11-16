import 'package:flutter/cupertino.dart';
import 'package:rehab_web/model/user.dart';
import 'package:rehab_web/ui/controller/doctor_controller.dart';
import 'package:rehab_web/ui/standard_widgets/obx_widget.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';
import 'package:rehab_web/ui/home/doctors_item.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../navigation_bar.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final DoctorController doctorController = Get.put(DoctorController());
  final key = GlobalKey<AnimatedListState>();
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

  final NavigationBarController navigationBarController = Get.find();
  bool isCheckedNutritional = false;
  bool isCheckedMedicines = true;
  bool isCheckedWorkout = false;
  bool isCheckedAddNewDoctor = false;
  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        doctorController,
        Material(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NavigationBar(),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Gerencie a equipe do hospital",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Expanded(
                          child: AnimatedList(
                            key: key,
                            initialItemCount: doctorController.listDoctors.length,
                            itemBuilder: (context, index, animation) => Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: buildItem(doctorController.listDoctors[index], index, animation),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ));
  }

  void removeItem(int index) async {
    final item = doctorController.listDoctors[index];
    await doctorController.deleteDoctor(item.cpf);
  }

  void insertItem(int index, DoctorModel item) {
    doctorController.listDoctors.insert(0, item);
    key.currentState.insertItem(index);
  }

  Widget buildItem(DoctorModel item, int index, Animation<double> animation) =>
      DoctorItem(item, icon: Icons.medical_services, color: RehabColors().mainColor, animation: animation,
          onClickItem: () {
        setState(() {
          isCheckedAddNewDoctor = doctorController.listDoctors[index].cdPaciente == 1 ? true : false;
          isCheckedMedicines = doctorController.listDoctors[index].cdMedicamento == 1 ? true : false;
          isCheckedWorkout = doctorController.listDoctors[index].cdExercicio == 1 ? true : false;
          isCheckedNutritional = doctorController.listDoctors[index].cdDieta == 1 ? true : false;
        });

        TextEditingController nameController =
            new TextEditingController(text: doctorController.listDoctors[index].nome);
        TextEditingController cpfController = new TextEditingController(text: doctorController.listDoctors[index].cpf);
        TextEditingController passwordController =
            new TextEditingController(text: doctorController.listDoctors[index].password);
        _selected = doctorController.listDoctors[index].tpEspecialista;
        TextEditingController emailController =
            new TextEditingController(text: doctorController.listDoctors[index].email);
        Alert(
            context: context,
            title: "Edição do especialista",
            style: AlertStyle(
                titleTextAlign: TextAlign.center,
                titleStyle: TextStyle(color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
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
                          hintText: doctorController.listDoctors[index].nome,
                          hintStyle: TextStyle(fontSize: 21.w)),
                    ),
                    TextField(
                        controller: emailController,
                        style: TextStyle(fontSize: 21.w),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                          hintText: doctorController.listDoctors[index].email,
                          labelStyle: TextStyle(fontSize: 21.w),
                          hintStyle: TextStyle(fontSize: 21.w),
                        )),
                    TextField(
                        controller: passwordController,
                        style: TextStyle(fontSize: 21.w),
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Senha',
                            hintText: doctorController.listDoctors[index].password,
                            labelStyle: TextStyle(fontSize: 21.w),
                            hintStyle: TextStyle(fontSize: 21.w))),
                    Container(
                      margin: EdgeInsets.only(top: 10.w),
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.w),
                          border: Border.all(color: Colors.black38, width: 1)),
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
                            state(() {
                              setState(() {
                                _selected = value;
                              });
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedMedicines,
                            onChanged: (bool value) {
                              state(() {
                                setState(() {
                                  isCheckedMedicines = value;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Medicamentos",
                              style: GoogleFonts.notoSans(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedAddNewDoctor,
                            onChanged: (bool value) {
                              state(() {
                                setState(() {
                                  isCheckedAddNewDoctor = value;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Cadastrar novo paciente",
                              style: GoogleFonts.notoSans(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedNutritional,
                            onChanged: (bool value) {
                              state(() {
                                setState(() {
                                  isCheckedNutritional = value;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Dietas e nutrição",
                              style: GoogleFonts.notoSans(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedWorkout,
                            onChanged: (bool value) {
                              state(() {
                                setState(() {
                                  isCheckedWorkout = value;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Atividade física",
                              style: GoogleFonts.notoSans(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            buttons: [
              DialogButton(
                onPressed: () async {
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
                    Get.snackbar('Sucesso', 'Especialista modificado!',
                        colorText: Colors.white,
                        backgroundColor: RehabColors().mainColor,
                        margin: EdgeInsets.symmetric(vertical: 35, horizontal: 130),
                        snackPosition: SnackPosition.TOP);
                    Get.back();
                  }
                  Get.back();
                },
                child: Text(
                  "Editar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: RehabColors().mainColor,
              ),
            ]).show();
      }, onClicked: () {
        Alert(
            context: context,
            title: "Tem certeza que deseja excluir esse especialista?",
            style: AlertStyle(
                titleTextAlign: TextAlign.center,
                titleStyle: TextStyle(color: Colors.black54, fontSize: 22),
                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
            buttons: [
              DialogButton(
                onPressed: () {
                  Get.back();
                  removeItem(index);
                },
                child: Text(
                  "Excluir",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.red,
              ),
              DialogButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: RehabColors().mainColor, fontSize: 20),
                ),
                color: Colors.white,
              ),
            ]).show();
      });
}
