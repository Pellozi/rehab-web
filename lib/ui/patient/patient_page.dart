import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehab_web/model/chat.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';
import 'package:rehab_web/ui/controller/care_controller.dart';
import 'package:rehab_web/ui/controller/chat_controller.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/patient/nutritional_page.dart';
import 'package:rehab_web/ui/patient/register_patient_page.dart';
import 'package:rehab_web/ui/patient/workout_page.dart';
import 'package:rehab_web/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rehab_web/utils/screen_util/flutter_screenutil.dart';
import '../navigation_bar.dart';
import 'general_care_page.dart';
import 'medicines_page.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  PageController _pageController;
  var _pageIndex = 0; //d
  final AuthController authController = Get.find();
  final NavigationBarController navigationBarController = Get.find();
  final CareController care = Get.put(CareController());
  final TextEditingController _textEditingController = TextEditingController(text: '');
  final ChatController chatController = Get.put(ChatController());
  @override
  void initState() {
    _pageController = PageController();
    care.getCares(navigationBarController.patient.value.cpf);
    care.getCareExercise(navigationBarController.patient.value.cpf);
    chatController.getChat(navigationBarController.patient.value.cpf, authController.user.value.cpf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        label: Text('Chat'),
        onPressed: () {
          Alert(
              context: context,
              title: "Chat",
              style: AlertStyle(
                  titleTextAlign: TextAlign.center,
                  titleStyle: TextStyle(color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
                  buttonAreaPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.w)),
              content: StatefulBuilder(builder: (context, state) {
                return Container(
                  width: 400.w,
                  height: 600.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.w,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: chatController.chats.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                                            child: Bubble(chat: chatController.chats[index]),
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(-2, 0),
                            blurRadius: 5,
                          ),
                        ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.w),
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 150.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.w),
                                    border: new Border.all(color: Colors.black26),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          scrollPadding: EdgeInsets.zero,
                                          keyboardType: TextInputType.text,
                                          onSubmitted: (val) async {
                                            await chatController.sendMessage(Chat((b) => b
                                              ..especialistaCpf = authController.user.value.cpf
                                              ..pacienteCpf = navigationBarController.patient.value.cpf
                                              ..mensagem = val
                                              ..destinatario = navigationBarController.patient.value.cpf
                                              ..remetente = authController.user.value.cpf
                                              ..visualizado = false));
                                            await chatController.getChat(navigationBarController.patient.value.cpf,
                                                authController.user.value.cpf);
                                            if (chatController.status.isSuccess) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                            }
                                          },
                                          cursorColor: Colors.black38.withOpacity(0.7),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 16.w, color: Colors.black54, fontWeight: FontWeight.w500),
                                            hintText: 'Escreva um comentário',
                                            hintMaxLines: 2,
                                          ),
                                          style: TextStyle(
                                              fontSize: 16.w, color: Colors.black54, fontWeight: FontWeight.w500),
                                          controller: _textEditingController,
                                          maxLines: null,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () async {
                                            await chatController.sendMessage(Chat((b) => b
                                              ..especialistaCpf = authController.user.value.cpf
                                              ..pacienteCpf = navigationBarController.patient.value.cpf
                                              ..mensagem = _textEditingController.text
                                              ..destinatario = navigationBarController.patient.value.cpf
                                              ..remetente = authController.user.value.cpf
                                              ..visualizado = false));
                                            await chatController.getChat(navigationBarController.patient.value.cpf,
                                                authController.user.value.cpf);
                                            if (chatController.status.isSuccess) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.w),
                                            child: Container(
                                              padding: EdgeInsets.all(10.w),
                                              decoration:
                                                  BoxDecoration(color: RehabColors().mainColor, shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.arrow_right_alt_sharp,
                                                color: Colors.white,
                                                size: 18.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              buttons: [
                DialogButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Fechar",
                    style: TextStyle(color: RehabColors().mainColor, fontSize: 20),
                  ),
                  color: Colors.white,
                ),
              ]).show();
        },
        icon: Icon(Icons.chat),
        backgroundColor: RehabColors().mainColor,
      ),
      body: Column(
        children: [
          NavigationBar(),
          SizedBox(
            height: 20,
          ),
          header(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              pageSnapping: false,
              onPageChanged: (index) {
                setState(() => _pageIndex = index);
              },
              children: [
                RegisterPatientPage(),
                if (authController.user.value.master == 1 || authController.user.value.cdMedicamento == 1)
                  MedicinesPage(),
                GeneralCarePage(),
                if (authController.user.value.master == 1 || authController.user.value.cdDieta == 1) NutritionalPage(),
                if (authController.user.value.master == 1 || authController.user.value.cdExercicio == 1) WorkoutPage()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(top: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 0;
                    _pageController.jumpToPage(0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 0 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Registro do paciente',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 0 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(width: 50),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 1;
                    _pageController.jumpToPage(1);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 1 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Medicamentos',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 1 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 2;
                    _pageController.jumpToPage(2);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 2 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Cuidados Gerais',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 2 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 3;
                    _pageController.jumpToPage(3);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 3 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Dieta e nutrição',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 3 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _pageIndex = 4;
                    _pageController.jumpToPage(4);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  decoration: BoxDecoration(
                      color: _pageIndex == 4 ? RehabColors().mainColor : Colors.black12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    'Atividades físicas',
                    style: GoogleFonts.notoSans(
                        color: _pageIndex == 4 ? Colors.white : RehabColors().grayColor, fontSize: 25),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final AuthController authController = Get.find();
  final ChatModel chat;

  Bubble({this.chat});

  Widget build(BuildContext context) {
    bool isMe = chat.remetente == chat.especialistaCpf || chat.remetente == authController.user.value.nome;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      padding: isMe ? EdgeInsets.only(left: 20.w) : EdgeInsets.only(right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
            children: <Widget>[
              if (!isMe)
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Colors.black12,
                  child: ClipOval(
                      child: Image(
                    image: AssetImage('assets/images/medical-team.png'),
                  )),
                ),
              if (chat.visualizado)
                Image.asset(
                  "assets/images/visualized.png",
                  color: RehabColors().mainColor,
                  height: 9.w,
                  width: 17.w,
                ),
              SizedBox(
                width: isMe ? 6.w : 10.w,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: isMe ? RehabColors().mainColor : Colors.black12,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10.r),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(0),
                          ),
                  ),
                  child: Text(
                    chat.mensagem,
                    textAlign: isMe ? TextAlign.start : TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.w, color: isMe ? Colors.white : Colors.black38, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
