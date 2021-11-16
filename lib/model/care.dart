import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_web/model/serializers.dart';
part 'care.g.dart';

abstract class Care implements Built<Care, CareBuilder> {
  @nullable
  String get pacienteCpf;
  @nullable
  String get especialistaCpf;
  @nullable
  int get tpCuidados;
  @nullable
  String get descricao;
  @nullable
  String get dtPublicacao;
  @nullable
  String get dtDuracao;
  @nullable
  String get observacao;
  @nullable
  String get quantidade;

  Care._();

  factory Care([updates(CareBuilder b)]) = _$Care;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(Care.serializer, this));
  }

  static Care fromJson(Object serialized) {
    return standardSerializers.deserializeWith(Care.serializer, serialized);
  }

  static Serializer<Care> get serializer => _$careSerializer;
}

abstract class CareExercise implements Built<CareExercise, CareExerciseBuilder> {
  @nullable
  String get pacienteCpf;
  @nullable
  String get especialistaCpf;
  @nullable
  String get descricao;
  @nullable
  String get exercicio;
  @nullable
  bool get realizado;
  @nullable
  String get dtPublicacao;
  @nullable
  String get dtDuracao;
  @nullable
  String get perEsforco;
  @nullable
  String get quantidade;
  @nullable
  String get observacao;

  CareExercise._();

  factory CareExercise([updates(CareExerciseBuilder b)]) = _$CareExercise;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(CareExercise.serializer, this));
  }

  static CareExercise fromJson(Object serialized) {
    return standardSerializers.deserializeWith(CareExercise.serializer, serialized);
  }

  static Serializer<CareExercise> get serializer => _$careExerciseSerializer;
}
