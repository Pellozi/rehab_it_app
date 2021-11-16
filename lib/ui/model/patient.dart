import 'package:built_value/built_value.dart';
import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:rehab_it/ui/model/serializers.dart';

part 'patient.g.dart';

abstract class Patient implements Built<Patient, PatientBuilder> {
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
  String get dtInicio;
  @nullable
  String get dtFim;
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
  bool get habilitado;
  @nullable
  String get nomeEspecialista;
  @nullable
  String get tpEspecialista;
  @nullable
  String get respCadastro;
  Patient._();

  factory Patient([updates(PatientBuilder b)]) = _$Patient;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(Patient.serializer, this));
  }

  static Patient fromJson(Object serialized) {
    return standardSerializers.deserializeWith(Patient.serializer, serialized);
  }

  static Serializer<Patient> get serializer => _$patientSerializer;
}
