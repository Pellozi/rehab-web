import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';
import 'package:rehab_web/ui/home/doctors_item.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingConfirmController = new TextEditingController();
  TextEditingController textEditingObservation = new TextEditingController();
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

  final NavigationBarController navigationBarController = Get.find();
  bool isCheckedNutritional = false;
  bool isCheckedMedicines = true;
  bool isCheckedWorkout = false;
  bool isCheckedAddNewDoctor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Text("Gerencie a equipe do hospital",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
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
                        initialItemCount: navigationBarController.doctors.length,
                        itemBuilder: (context, index, animation) =>
                            buildItem(navigationBarController.doctors[index], index, animation),
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
    );
  }

  void removeItem(int index) {
    final item = navigationBarController.doctors.removeAt(index);
    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }

  void insertItem(int index, Item item) {
    navigationBarController.doctors.insert(0, item);
    key.currentState.insertItem(index);
  }

  Widget buildItem(item, int index, Animation<double> animation) =>
      DoctorItem(item, icon: Icons.medical_services, color: RehabColors().mainColor, animation: animation,
          onClickItem: () {
        Alert(
            context: context,
            title: "Edição do especialista",
            style: AlertStyle(
                titleTextAlign: TextAlign.center,
                titleStyle: TextStyle(color: Colors.black54, fontSize: 22),
                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: navigationBarController.doctors[index].description,
                      hintText: navigationBarController.doctors[index].description,
                    ),
                  ),
                  TextField(
                      decoration:
                          InputDecoration(icon: Icon(Icons.person), labelText: '12375687955', hintText: '12375687955')),
                  TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.email), labelText: 'andressa@gmail.com', hintText: 'andressa@gmail.com')),
                  TextField(decoration: InputDecoration(icon: Icon(Icons.lock), labelText: '123', hintText: '123')),
                  TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.medical_services), labelText: 'Enfermeira', hintText: 'Enfermeira')),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
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
                            setState(() {
                              isCheckedAddNewDoctor = value;
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
                            setState(() {
                              isCheckedNutritional = value;
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
                            setState(() {
                              isCheckedWorkout = value;
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
            ),
            buttons: [
              DialogButton(
                onPressed: () {
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
