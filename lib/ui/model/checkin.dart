import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:rehab_it/ui/model/serializers.dart';
part 'checkin.g.dart';

abstract class Incident implements Built<Incident, IncidentBuilder> {
  @nullable
  String get cpf;
  @nullable
  String get incidente;
  @nullable
  String get dtRelato;
  Incident._();

  factory Incident([updates(IncidentBuilder b)]) = _$Incident;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(Incident.serializer, this));
  }

  static Incident fromJson(Object serialized) {
    return standardSerializers.deserializeWith(Incident.serializer, serialized);
  }

  static Serializer<Incident> get serializer => _$incidentSerializer;
}

abstract class Monitoring implements Built<Monitoring, MonitoringBuilder> {
  @nullable
  int get seq;
  @nullable
  String get cpf;
  @nullable
  String get pressao;
  @nullable
  String get glicemia;
  @nullable
  String get data;
  @nullable
  String get saturacao;
  @nullable
  String get temperatura;
  @nullable
  int get bemEstar;
  @nullable
  String get observacao;
  @nullable
  String get freqCardiacaPre;
  @nullable
  String get peso;
  @nullable
  String get freqCardiacaPos;
  Monitoring._();

  factory Monitoring([updates(MonitoringBuilder b)]) = _$Monitoring;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(Monitoring.serializer, this));
  }

  static Monitoring fromJson(Object serialized) {
    return standardSerializers.deserializeWith(Monitoring.serializer, serialized);
  }

  static Serializer<Monitoring> get serializer => _$monitoringSerializer;
}
