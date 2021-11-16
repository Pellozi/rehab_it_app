import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:rehab_it/ui/model/chat.dart';
import 'package:rehab_it/ui/provider/api_provider.dart';
import 'package:http/http.dart' as http;
import 'base_controller.dart';
import 'package:dio/dio.dart' as api;

class ChatController extends BaseController {
  var chats = <ChatModel>[].obs;
  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  Future<void> getChat(String cpfPaciente, String cpfEspecialista) async {
    change([], status: RxStatus.loading());
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiProvider.instance.apiBaseUrl}chat/getChat?pacienteCpf=$cpfPaciente&especialistaCpf=$cpfEspecialista'),
        headers: {'Authorization': 'Bearer ${ApiProvider.instance.token}'},
      );
      final List<dynamic> responseMap = jsonDecode(response.body);
      final List<ChatModel> messages =
          responseMap.map<ChatModel>((m) => ChatModel.fromMap(Map<String, dynamic>.from(m))).toList();
      chats.value = messages;
      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.success());
      print(error);
    }
  }

  Future<void> sendMessage(Chat chat) async {
    change([], status: RxStatus.loading());
    try {
      var dio = api.Dio();

      final response = await dio.post('${ApiProvider.instance.apiBaseUrl}chat/addChat',
          data: chat.toJson(),
          options: api.Options(
            headers: {
              'authorization': 'Bearer ${ApiProvider.instance.token}',
            },
          ));

      change([], status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error(error.message));
      print(error);
    }
  }
}

class ChatModel {
  int seq;
  String pacienteCpf;
  String especialistaCpf;
  String destinatario;
  String remetente;
  String mensagem;
  bool visualizado;
  String envio;

  ChatModel({
    this.seq,
    this.pacienteCpf,
    this.especialistaCpf,
    this.destinatario,
    this.remetente,
    this.mensagem,
    this.visualizado,
    this.envio,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatModel(
      seq: map['seq'] ?? 0,
      pacienteCpf: map['pacienteCpf'] ?? '',
      especialistaCpf: map['especialistaCpf'] ?? '',
      destinatario: map['destinatario'] ?? '',
      remetente: map['remetente'] ?? '',
      mensagem: map['mensagem'] ?? '',
      visualizado: map['visualizado'] ?? false,
      envio: map['envio'] ?? '',
    );
  }

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));
}
