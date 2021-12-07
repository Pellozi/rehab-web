import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_web/model/serializers.dart';
import 'package:built_collection/built_collection.dart';
part 'patient.g.dart';

abstract class PatientResponse implements Built<PatientResponse, PatientResponseBuilder> {
  @nullable
  String get cpf;
  @nullable
  String get nome;
  @nullable
  String get email;
  @nullable
  String get password;
  @nullable
  String get evento;
  @nullable
  String get tratamento;
  @nullable
  String get dtReabilitacao;
  @nullable
  bool get fumante;
  @nullable
  bool get diabetico;
  @nullable
  double get altura;
  @nullable
  int get nrDias;
  @nullable
  String get respCadastro;
  @nullable
  bool get habilitado;
  PatientResponse._();

  factory PatientResponse([updates(PatientResponseBuilder b)]) = _$PatientResponse;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(PatientResponse.serializer, this));
  }

  static PatientResponse fromJson(Object serialized) {
    return standardSerializers.deserializeWith(PatientResponse.serializer, serialized);
  }

  static Serializer<PatientResponse> get serializer => _$patientResponseSerializer;
}
