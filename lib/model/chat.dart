import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_web/model/serializers.dart';

part 'chat.g.dart';

abstract class Chat implements Built<Chat, ChatBuilder> {
  @nullable
  String get pacienteCpf;
  @nullable
  String get especialistaCpf;
  @nullable
  String get destinatario;
  @nullable
  String get remetente;
  @nullable
  String get mensagem;
  @nullable
  bool get visualizado;
  Chat._();

  factory Chat([updates(ChatBuilder b)]) = _$Chat;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(Chat.serializer, this));
  }

  static Chat fromJson(Object serialized) {
    return standardSerializers.deserializeWith(Chat.serializer, serialized);
  }

  static Serializer<Chat> get serializer => _$chatSerializer;
}
