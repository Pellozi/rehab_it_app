import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:rehab_it/ui/provider/api_provider.dart';
import 'package:http/http.dart' as http;
import 'base_controller.dart';

class DoctorController extends BaseController {
  var listDoctors = <DoctorModel>[].obs;
  @override
  void onInit() {
    getDoctors();
    change([], status: RxStatus.success());
    super.onInit();
  }

  Future<void> getDoctors() async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse('${ApiProvider.instance.apiBaseUrl}especialista/listEspecialista'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(response.body);
      final List<DoctorModel> doctors =
          responseMap.map<DoctorModel>((m) => DoctorModel.fromMap(Map<String, dynamic>.from(m))).toList();
      listDoctors.value = doctors;
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }
}

class DoctorModel {
  String cpf;

  String nome;

  String email;

  String password;

  String tpEspecialista;

  int master;

  int cdPaciente;

  int cdMedicamento;

  int cdDieta;
  int cdExercicio;

  DoctorModel({
    this.cpf,
    this.nome,
    this.email,
    this.tpEspecialista,
    this.cdMedicamento,
    this.cdPaciente,
    this.password,
    this.cdDieta,
    this.master,
    this.cdExercicio,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DoctorModel(
      cpf: map['cpf'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      tpEspecialista: map['tpEspecialista'] ?? '',
      password: map['password'] ?? '',
      master: map['master'] ?? 0,
      cdMedicamento: map['cdMedicamento'] ?? 0,
      cdPaciente: map['cdPaciente'] ?? 0,
      cdExercicio: map['cdExercicio'] ?? 0,
      cdDieta: map['cdDieta'] ?? 0,
    );
  }

  factory DoctorModel.fromJson(String source) => DoctorModel.fromMap(json.decode(source));
}
