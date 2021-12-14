import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as api;

import 'package:get/get.dart';
import 'package:rehab_web/model/patient.dart';
import 'package:rehab_web/provider/api_provider.dart';
import 'package:http/http.dart' as http;
import 'base_controller.dart';

class PatientController extends BaseController {
  var patient = PatientResponse().obs;
  var listPatient = <PatientModel>[].obs;
  @override
  void onInit() {
    getPatients();
    super.onInit();
  }

  Future<void> getPatients() async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}paciente/listPaciente'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(utf8.decode(response.bodyBytes));
      final List<PatientModel> patients =
          responseMap.map<PatientModel>((m) => PatientModel.fromMap(Map<String, dynamic>.from(m))).toList();
      listPatient.value = patients;
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }

  Future<void> createPatient(PatientResponse patient) async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();

      final response = await dio.post('${ApiProvider.instance.apiBaseUrl}paciente/addPaciente',
          data: patient.toJson(),
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
}

class PatientModel {
  String cpf;

  String nome;

  String email;

  String password;

  String evento;

  String tratamento;

  String dtInicio;

  String dtFim;

  String dtReabilitacao;

  bool fumante;

  bool diabetico;

  double altura;

  int nrDias;

  String nomeEspecialista;

  bool habilitado;
  PatientModel(
      {this.cpf,
      this.nome,
      this.email,
      this.dtReabilitacao,
      this.altura,
      this.fumante,
      this.diabetico,
      this.password,
      this.tratamento,
      this.evento,
      this.dtFim,
      this.dtInicio,
      this.nrDias,
      this.habilitado,
      this.nomeEspecialista});

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PatientModel(
      cpf: map['cpf'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      dtReabilitacao: map['dtReabilitacao'] ?? '',
      password: map['password'] ?? '',
      tratamento: map['tratamento'] ?? '',
      evento: map['evento'] ?? '',
      dtFim: map['dtFim'] ?? '',
      dtInicio: map['dtInicio'] ?? '',
      nomeEspecialista: map['nomeEspecialista'] ?? '',
      fumante: map['fumante'] ?? false,
      diabetico: map['diabetico'] ?? false,
      altura: map['altura'] ?? 0.0,
      nrDias: map['nrDias'] ?? 0,
      habilitado: map['habilitado'] ?? false,
    );
  }

  factory PatientModel.fromJson(String source) => PatientModel.fromMap(json.decode(source));
}
