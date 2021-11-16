import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/model/care.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';
import 'package:rehab_web/ui/controller/care_controller.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';

import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rehab_web/utils/date_formatting.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import 'item_widget.dart';

class WorkoutPage extends StatelessWidget {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LargeChild(),
    );
  }
}

class LargeChild extends StatefulWidget {
  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild> {
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingConfirmController = new TextEditingController();
  TextEditingController textEditingObservation = new TextEditingController();
  TextEditingController textEditingData = new TextEditingController();
  final key = GlobalKey<AnimatedListState>();
  final NavigationBarController navigationBarController = Get.find();
  final CareController careController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: widthContainer(context), vertical: 25.w),
      children: <Widget>[
        SizedBox(
          height: 25.w,
        ),
        Text("Insiria os exercícios físicos para o paciente",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
        SizedBox(
          height: 25.w,
        ),
        Obx(() => Container(
              height: (110.w * careController.listExercise.length) + 175.w,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Expanded(
                        child: AnimatedList(
                          key: key,
                          initialItemCount: careController.listExercise.length,
                          itemBuilder: (context, index, animation) => Column(
                            children: [
                              buildItem(careController.listExercise[index], index, animation),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
                    child: SendBtn(
                      'Adicionar',
                      width: 400.w,
                      hasPadding: false,
                      onTap: () {
                        Alert(
                            context: context,
                            title: "Adicione um exercício",
                            style: AlertStyle(
                                titleTextAlign: TextAlign.center,
                                titleStyle: TextStyle(color: Colors.black54, fontSize: 22.w),
                                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.w)),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  controller: textEditingConfirmController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.fitness_center_outlined),
                                    labelText: 'Nome',
                                  ),
                                ),
                                TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.history),
                                    labelText: 'Repetições',
                                  ),
                                ),
                                TextField(
                                  controller: textEditingData,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.history),
                                    labelText: 'Quantidade de dias',
                                  ),
                                ),
                                TextField(
                                  controller: textEditingObservation,
                                  maxLines: 2,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.black38, fontSize: 18.w),
                                  decoration: InputDecoration(
                                    labelText: 'Descreva o exercício',
                                    icon: Icon(Icons.wysiwyg),
                                    labelStyle: TextStyle(color: Colors.black38, fontSize: 18.w),
                                  ),
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () {
                                  Get.back();
                                  insertItem(
                                      careController.listExercise.length, new Item(textEditingConfirmController.text));
                                },
                                child: Text(
                                  "Salvar",
                                  style: TextStyle(color: Colors.white, fontSize: 20.w),
                                ),
                                color: RehabColors().mainColor,
                              )
                            ]).show();
                      },
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  double widthContainer(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1200) return 150.w;
    if (MediaQuery.of(context).size.width < 1400) return 350.w;
    if (MediaQuery.of(context).size.width < 1538) return 400.w;

    return 550.w;
  }

  void removeItem(int index) {
    Alert(
        context: context,
        title: "Tem certeza que deseja excluir?",
        style: AlertStyle(
            titleTextAlign: TextAlign.center,
            titleStyle: TextStyle(color: Colors.black54, fontSize: 22),
            buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
        buttons: [
          DialogButton(
            onPressed: () async {
              final item = careController.listExercise[index];
              key.currentState.removeItem(
                index,
                (context, animation) => buildItem(item, index, animation),
              );
              await careController.deleteCareExercise(careController.listExercise[index].id);
              await careController.getCares(careController.listExercise[index].pacienteCpf);
              Get.back();
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
  }

  void insertItem(int index, Item item) async {
    final AuthController authController = Get.find();
    final NavigationBarController navigationBarController = Get.find();
    await careController.createCareExercise(CareExercise((b) => b
      ..descricao = textEditingConfirmController.text
      ..exercicio = textEditingObservation.text
      ..realizado = false
      ..perEsforco = '1'
      ..quantidade = textEditingController.text
      ..dtPublicacao = dateAsDBFormat(DateTime.now())
      ..especialistaCpf = authController.user.value.cpf
      ..observacao = 'observação'
      ..pacienteCpf = navigationBarController.patient.value.cpf
      ..dtDuracao = dateAsDBFormat(new DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + int.tryParse(textEditingData.text), 0, 0, 0, 0, 0))));

    await careController.getCareExercise(navigationBarController.patient.value.cpf);
    Future.delayed(Duration(milliseconds: 500), () {
      key.currentState.insertItem(index);
    });
  }

  Widget buildItem(CareExerciseModel item, int index, Animation<double> animation) => ItemExerciseWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );
}
