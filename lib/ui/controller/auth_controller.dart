import 'dart:async';

import 'package:dio/dio.dart' as api;
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rehab_web/model/auth.dart';
import 'package:rehab_web/model/user.dart';
import 'package:rehab_web/provider/api_provider.dart';

import 'base_controller.dart';

class AuthController extends BaseController {
  var login = ''.obs;
  var password = ''.obs;
  var user = User().obs;
  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  Future<void> auth() async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();
      var formData =
          api.FormData.fromMap({'username': login.value, 'password': password.value, 'grant_type': 'password'});

      final response = await dio.post('${ApiProvider.instance.apiBaseUrl}oauth/token',
          data: formData,
          options: api.Options(
            headers: {
              'authorization': 'Basic cmVoYWJpdDpxYS40NzM2',
            },
          ));

      print(response.data);

      AuthResponse authResponse = AuthResponse.fromJson(response.data);

      ApiProvider.instance.token = authResponse.access_token;

      GetStorage box = GetStorage();
      box.write('token', authResponse.access_token);
      print(authResponse.access_token);
      await userInfo(login.value);
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }

  Future<void> userInfo(String cpf) async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();

      final response = await dio.get('${ApiProvider.instance.apiBaseUrl}especialista/getByCpf?cpf=$cpf',
          options: api.Options(
            headers: {
              'authorization': 'Bearer ${ApiProvider.instance.token}',
            },
          ));

      User userResponse = User.fromJson(response.data);

      user.value = userResponse;
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }
}
