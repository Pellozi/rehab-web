import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as api;

import 'package:get/get.dart';
import 'package:rehab_web/model/care.dart';

import 'package:rehab_web/provider/api_provider.dart';
import 'package:http/http.dart' as http;
import 'base_controller.dart';

class CareController extends BaseController {
  var listCares = <CareModel>[].obs;
  var listMedicines = <CareModel>[].obs;
  var listGeneral = <CareModel>[].obs;
  var listNutritional = <CareModel>[].obs;
  var listExercise = <CareExerciseModel>[].obs;
  var listExerciseEsforco = <CareExerciseModel>[].obs;
  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  Future<void> getCares(String cpf) async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}cuidados/getByCpf?cpf=$cpf'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(response.body);
      final List<CareModel> cares =
          responseMap.map<CareModel>((m) => CareModel.fromMap(Map<String, dynamic>.from(m))).toList();
      listCares.value = cares;
      listMedicines.value = listCares.where((p0) => p0.tpCuidados == '2').toList();
      listGeneral.value = listCares.where((p0) => p0.tpCuidados == '3').toList();
      listNutritional.value = listCares.where((p0) => p0.tpCuidados == '1').toList();
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }

  Future<void> getCareExercise(String cpf) async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}cuidados/getExercicioByCpf?cpf=$cpf'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(response.body);
      final List<CareExerciseModel> cares =
          responseMap.map<CareExerciseModel>((m) => CareExerciseModel.fromMap(Map<String, dynamic>.from(m))).toList();
      listExercise.value = cares;
      listExerciseEsforco.value = listExercise.where((p0) => p0.perEsforco != 0).toList();
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }

  Future<void> createCare(Care care) async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();

      final response = await dio.post('${ApiProvider.instance.apiBaseUrl}cuidados/addCuidados',
          data: care.toJson(),
          options: api.Options(
            headers: {
              'authorization': 'Bearer ${ApiProvider.instance.token}',
            },
          ));

      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }

  Future<void> createCareExercise(CareExercise care) async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();

      final response = await dio.post('${ApiProvider.instance.apiBaseUrl}cuidados/addExercicios',
          data: care.toJson(),
          options: api.Options(
            headers: {
              'authorization': 'Bearer ${ApiProvider.instance.token}',
            },
          ));

      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }

  Future<void> deleteCare(int id) async {
    change([], status: RxStatus.loading());
    try {
      await http.delete(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}cuidados/delCuidado?id=$id'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }

  Future<void> deleteCareExercise(int id) async {
    change([], status: RxStatus.loading());
    try {
      await http.delete(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}cuidados/delExercicio?id=$id'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }
}

class CareModel {
  int id;
  String pacienteCpf;
  String especialistaCpf;
  String tpCuidados;
  String descricao;
  String dtPublicacao;
  String dtDuracao;
  String quantidade;
  String observacao;

  CareModel(
      {this.id,
      this.pacienteCpf,
      this.especialistaCpf,
      this.tpCuidados,
      this.descricao,
      this.dtPublicacao,
      this.dtDuracao,
      this.quantidade,
      this.observacao});

  factory CareModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CareModel(
      id: map['id'] ?? '',
      pacienteCpf: map['pacienteCpf'] ?? '',
      especialistaCpf: map['especialistaCpf'] ?? '',
      tpCuidados: map['tpCuidados'] ?? '',
      descricao: map['descricao'] ?? '',
      dtPublicacao: map['dtPublicacao'] ?? '',
      dtDuracao: map['dtDuracao'] ?? '',
      quantidade: map['quantidade'] ?? '',
      observacao: map['observacao'] ?? '',
    );
  }

  factory CareModel.fromJson(String source) => CareModel.fromMap(json.decode(source));
}

class CareExerciseModel {
  int id;
  String pacienteCpf;
  String especialistaCpf;
  String descricao;
  String dtPublicacao;
  String dtDuracao;
  String quantidade;
  String observacao;
  int perEsforco;
  bool realizado;
  String exercicio;

  CareExerciseModel(
      {this.id,
      this.pacienteCpf,
      this.especialistaCpf,
      this.descricao,
      this.dtPublicacao,
      this.dtDuracao,
      this.quantidade,
      this.observacao,
      this.perEsforco,
      this.realizado,
      this.exercicio});

  factory CareExerciseModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CareExerciseModel(
      id: map['id'] ?? '',
      pacienteCpf: map['pacienteCpf'] ?? '',
      especialistaCpf: map['especialistaCpf'] ?? '',
      descricao: map['descricao'] ?? '',
      dtPublicacao: map['dtPublicacao'] ?? '',
      dtDuracao: map['dtDuracao'] ?? '',
      quantidade: map['quantidade'] ?? '',
      observacao: map['observacao'] ?? '',
      exercicio: map['exercicio'] ?? '',
      perEsforco: map['perEsforco'] ?? 0,
      realizado: map['realizado'] ?? false,
    );
  }

  factory CareExerciseModel.fromJson(String source) => CareExerciseModel.fromMap(json.decode(source));
}
