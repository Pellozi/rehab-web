import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/base_controller.dart';
import 'package:rehab_web/utils/colors.dart';

class RehabObxWidget extends GetView<BaseController> {
  final BaseController controller;
  final Function onEmpty;
  final Function onError;
  final Widget child;
  final Color loadingColor;
  final Color backgroundLoadingColor;
  RehabObxWidget(this.controller, this.child,
      {this.onEmpty,
      this.onError,
      this.loadingColor = const Color(0xFF7E52F3),
      this.backgroundLoadingColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => child,
      onEmpty: this.onEmpty ?? Center(child: Text("vazio")),
      onLoading: Center(
        child: CircularProgressIndicator(
          color: RehabColors().mainColor,
        ),
      ),
      onError: this.onError ??
          (error) => Column(
                children: [
                  Text(
                    error,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Center(
                    child: TextButton(
                      child: Text("tentar novamente"),
                      onPressed: () {
                        controller.finishLoading();
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
