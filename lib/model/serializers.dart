library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rehab_web/model/care.dart';
import 'package:rehab_web/model/patient.dart';
import 'package:rehab_web/model/user.dart';

import 'auth.dart';
import 'chat.dart';

part 'serializers.g.dart';

@SerializersFor(const [AuthResponse, User, PatientResponse, Care, CareExercise, Chat])
final Serializers serializers = _$serializers;

final standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
