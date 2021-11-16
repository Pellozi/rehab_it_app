library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rehab_it/ui/model/auth.dart';
import 'package:rehab_it/ui/model/patient.dart';

import 'care.dart';
import 'chat.dart';
import 'checkin.dart';

part 'serializers.g.dart';

@SerializersFor(const [Care, CareExercise, Patient, AuthResponse, Chat, Incident, Monitoring])
final Serializers serializers = _$serializers;

final standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
