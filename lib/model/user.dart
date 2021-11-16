import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_web/model/serializers.dart';
part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  @nullable
  String get cpf;
  @nullable
  String get password;
  @nullable
  String get nome;
  @nullable
  String get email;
  @nullable
  String get tpEspecialista;
  @nullable
  int get master;
  @nullable
  int get cdPaciente;
  @nullable
  int get cdMedicamento;
  @nullable
  int get cdDieta;
  @nullable
  int get cdExercicio;

  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(User.serializer, this));
  }

  static User fromJson(Object serialized) {
    return standardSerializers.deserializeWith(User.serializer, serialized);
  }

  static Serializer<User> get serializer => _$userSerializer;
}
