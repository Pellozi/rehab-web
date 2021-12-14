import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:rehab_web/provider/api_provider.dart';
import 'base_controller.dart';
import 'package:dio/dio.dart' as api;

class CheckInController extends BaseController {
  var incidents = <IncidentModel>[].obs;
  var monitoring = <MonitoringModel>[].obs;
  var glicemia = <MonitoringModel>[].obs;
  var temperatura = <MonitoringModel>[].obs;
  var saturacao = <MonitoringModel>[].obs;
  var bemEstar = <MonitoringModel>[].obs;
  var pressao = <MonitoringModel>[].obs;
  var freqCardiacaPre = <MonitoringModel>[].obs;
  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  Future<void> getIMonitoring(String cpfPaciente) async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}checkin/listMonitoramento?cpf=$cpfPaciente'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<MonitoringModel> incidentsList =
          responseMap.map<MonitoringModel>((m) => MonitoringModel.fromMap(Map<String, dynamic>.from(m))).toList();
      monitoring.value = incidentsList;
      glicemia.value = monitoring.where((element) => element.glicemia != null && element.glicemia.isNotEmpty).toList();
      temperatura.value =
          monitoring.where((element) => element.temperatura != null && element.temperatura.isNotEmpty).toList();
      saturacao.value =
          monitoring.where((element) => element.saturacao != null && element.saturacao.isNotEmpty).toList();
      bemEstar.value = monitoring.where((element) => element.bemEstar != null && element.bemEstar != 0).toList();
      pressao.value = monitoring.where((element) => element.pressao != null && element.pressao.isNotEmpty).toList();
      freqCardiacaPre.value =
          monitoring.where((element) => element.freqCardiacaPre != null && element.freqCardiacaPre.isNotEmpty).toList();
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }

  Future<void> getIncidents(String cpfPaciente) async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}checkin/listIncidentes?cpf=$cpfPaciente'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<IncidentModel> incidentsList =
          responseMap.map<IncidentModel>((m) => IncidentModel.fromMap(Map<String, dynamic>.from(m))).toList();
      incidents.value = incidentsList;
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }
}

class IncidentModel {
  String cpf;
  String incidente;
  String dtRelato;

  IncidentModel({
    this.cpf,
    this.incidente,
    this.dtRelato,
  });

  factory IncidentModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return IncidentModel(
      cpf: map['cpf'] ?? '',
      incidente: map['incidente'] ?? '',
      dtRelato: map['dtRelato'] ?? '',
    );
  }

  factory IncidentModel.fromJson(String source) => IncidentModel.fromMap(json.decode(source));
}

class MonitoringModel {
  int seq;
  String cpf;
  String pressao;
  String dtCadastro;
  String data;
  String glicemia;
  String temperatura;
  String saturacao;
  String observacao;
  String freqCardiacaPre;
  int bemEstar;
  MonitoringModel(
      {this.cpf,
      this.pressao,
      this.dtCadastro,
      this.bemEstar,
      this.freqCardiacaPre,
      this.glicemia,
      this.saturacao,
      this.observacao,
      this.temperatura,
      this.data,
      this.seq});

  factory MonitoringModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MonitoringModel(
      cpf: map['cpf'] ?? '',
      pressao: map['pressao'] ?? '',
      dtCadastro: map['dtCadastro'] ?? '',
      glicemia: map['glicemia'] ?? '',
      saturacao: map['saturacao'] ?? '',
      temperatura: map['temperatura'] ?? '',
      observacao: map['observacao'] ?? '',
      freqCardiacaPre: map['freqCardiacaPre'] ?? '',
      data: map['data'] ?? '',
      bemEstar: map['bemEstar'] ?? 0,
      seq: map['seq'] ?? 0,
    );
  }

  factory MonitoringModel.fromJson(String source) => MonitoringModel.fromMap(json.decode(source));
}
