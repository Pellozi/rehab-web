import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';

import 'package:rehab_web/ui/standard_widgets/search_widget.dart';
import 'package:rehab_web/ui/standard_widgets/send_button_widget.dart';
import 'package:rehab_web/utils/colors.dart';

import 'package:rehab_web/utils/responsive_layout.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'item_widget.dart';

class GeneralCarePage extends StatelessWidget {
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

  final key = GlobalKey<AnimatedListState>();
  final NavigationBarController navigationBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Text("Insiria os medicamentos para o seu paciente",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF8591B0))),
        SizedBox(
          height: 25,
        ),
        Container(
          height: 600,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Expanded(
                    child: AnimatedList(
                      key: key,
                      initialItemCount: navigationBarController.generalItems.length,
                      itemBuilder: (context, index, animation) => Column(
                        children: [
                          buildItem(navigationBarController.generalItems[index], index, animation),
                          if (navigationBarController.generalItems[index] == navigationBarController.generalItems.last)
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: SendBtn(
                                'Adicionar',
                                hasPadding: false,
                                onTap: () {
                                  Alert(
                                      context: context,
                                      title: "Adicione um medicamento",
                                      style: AlertStyle(
                                          titleTextAlign: TextAlign.center,
                                          titleStyle: TextStyle(color: Colors.black54, fontSize: 22),
                                          buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          TextField(
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.history),
                                              labelText: 'Observações',
                                            ),
                                          ),
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          onPressed: () {
                                            Get.back();
                                            insertItem(
                                                index,
                                                new Item(
                                                  textEditingController.text,
                                                ));
                                          },
                                          child: Text(
                                            "Salvar",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                          color: RehabColors().mainColor,
                                        )
                                      ]).show();
                                },
                              ),
                            )
                        ],
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
    );
  }

  void removeItem(int index) {
    final item = navigationBarController.generalItems.removeAt(index);
    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }

  void insertItem(int index, Item item) {
    navigationBarController.generalItems.insert(0, item);
    key.currentState.insertItem(index);
  }

  Widget buildItem(item, int index, Animation<double> animation) => ItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );
}
