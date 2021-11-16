import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/auth_controller.dart';
import 'package:rehab_web/ui/controller/navigation_bar_controller.dart';
import 'package:rehab_web/ui/home/home_page.dart';
import 'package:rehab_web/ui/standard_widgets/obx_widget.dart';
import 'package:rehab_web/utils/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NavigationBarController navigationBarController = Get.put(NavigationBarController(), permanent: true);
  TextEditingController textEditingLoginController = new TextEditingController(text: '');
  TextEditingController textEditingPasswordController = new TextEditingController(text: '');
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RehabObxWidget(
        authController,
        Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: size.width / 2,
                      color: RehabColors().mainColor,
                    ),
                    Container(height: double.infinity, width: size.width / 2, color: Colors.white),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      "Rehab.it",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (widget, animation) => ScaleTransition(child: widget, scale: animation),
                    child: loginCard(context)),
              ],
            ),
          ),
        ));
  }

  Widget loginCard(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 8)]),
          duration: Duration(milliseconds: 200),
          height: size.height *
              (size.height > 770
                  ? 0.7
                  : size.height > 670
                      ? 0.8
                      : 0.9),
          width: 500,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bem-vindo",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 30,
                      child: Divider(
                        color: RehabColors().mainColor,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: textEditingLoginController,
                      onChanged: (value) {
                        authController.login.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Login',
                        labelText: 'Login(cpf)',
                        suffixIcon: Icon(
                          Icons.mail_outline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      obscureText: true,
                      controller: textEditingPasswordController,
                      onChanged: (value) {
                        navigationBarController.password.value = value;
                        authController.password.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        labelText: 'Senha',
                        suffixIcon: Icon(
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await authController.auth();

                        if (authController.status.isSuccess) Get.to(HomePage(), transition: Transition.rightToLeft);
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: RehabColors().mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: RehabColors().mainColor.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
