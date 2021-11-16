import 'package:get/get.dart';

class BaseController extends GetxController with StateMixin {

  @override
  void onInit() {
    super.onInit();
  }

  void startLoading() {
    change([], status: RxStatus.loading());
  }

  void finishLoading() {
    change([], status: RxStatus.success());
  }
}
