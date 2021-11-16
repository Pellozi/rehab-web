import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_web/model/serializers.dart';
part 'auth.g.dart';

abstract class AuthResponse implements Built<AuthResponse, AuthResponseBuilder> {
  String get access_token;
  String get token_type;
  String get refresh_token;
  int get expires_in;
  String get scope;
  AuthResponse._();

  factory AuthResponse([updates(AuthResponseBuilder b)]) = _$AuthResponse;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(AuthResponse.serializer, this));
  }

  static AuthResponse fromJson(Object serialized) {
    return standardSerializers.deserializeWith(AuthResponse.serializer, serialized);
  }

  static Serializer<AuthResponse> get serializer => _$authResponseSerializer;
}
