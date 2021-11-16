import 'package:get/get.dart';
import 'package:rehab_web/ui/controller/patient_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';

class NavigationBarController extends GetxController with StateMixin {
  var index = 0.obs;
  var password = ''.obs;
  var patient = PatientModel().obs;
  @override
  void onInit() {
    super.onInit();
  }
}
