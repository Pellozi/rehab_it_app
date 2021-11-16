import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/controller/auth_controller.dart';
import 'package:rehab_it/ui/controller/chat_controller.dart';
import 'package:rehab_it/ui/controller/doctor_controller.dart';
import 'package:rehab_it/ui/model/chat.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';

import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/ui/standard_widgets/app_bar.dart';
import 'package:rehab_it/utils/colors.dart';

class ChatConversationPage extends StatefulWidget {
  final DoctorModel model;
  ChatConversationPage(this.model);
  @override
  _ChatConversationPageState createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  TextEditingController _textEditingController = new TextEditingController();
  ScrollController _controller = ScrollController();
  final ChatController chatController = Get.find();
  final AuthController authController = Get.find();
  @override
  void initState() {
    init();

    super.initState();
  }

  Future<void> init() async {
    await chatController.getChat(authController.patient.value.cpf, widget.model.cpf);
  }

  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        chatController,
        Scaffold(
            backgroundColor: Colors.white,
            appBar: StandardAppBarWidget(
              hasBackButton: true,
            ),
            body: Stack(
              children: <Widget>[
                RawGestureDetector(
                  gestures: {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.w,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                                child: Obx(() => ListView.builder(
                                    controller: _controller,
                                    shrinkWrap: true,
                                    itemCount: chatController.chats.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(onTap: () {}, child: Bubble(chat: chatController.chats[index]));
                                    })),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: (20.w), vertical: 5.w),
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(-2, 0),
                            blurRadius: 5,
                          ),
                        ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.w),
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 150.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.w),
                                    border: new Border.all(color: Colors.black26),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          scrollPadding: EdgeInsets.zero,
                                          keyboardType: TextInputType.text,
                                          onSubmitted: (val) async {
                                            await chatController.sendMessage(Chat((b) => b
                                              ..especialistaCpf = widget.model.cpf
                                              ..pacienteCpf = authController.patient.value.cpf
                                              ..mensagem = val
                                              ..destinatario = widget.model.cpf
                                              ..remetente = authController.patient.value.cpf
                                              ..visualizado = false));
                                            await chatController.getChat(
                                                authController.patient.value.cpf, widget.model.cpf);
                                            if (chatController.status.isSuccess) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                            }
                                          },
                                          cursorColor: Colors.black38.withOpacity(0.7),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 13.w, color: Colors.black26, fontWeight: FontWeight.w500),
                                            hintText: 'Escreva um comentário',
                                            hintMaxLines: 2,
                                          ),
                                          style: TextStyle(
                                              fontSize: 13.w, color: Colors.black26, fontWeight: FontWeight.w500),
                                          controller: _textEditingController,
                                          maxLines: null,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () async {
                                            await chatController.sendMessage(Chat((b) => b
                                              ..especialistaCpf = widget.model.cpf
                                              ..pacienteCpf = authController.patient.value.cpf
                                              ..mensagem = _textEditingController.text
                                              ..destinatario = widget.model.nome
                                              ..remetente = authController.patient.value.nome
                                              ..visualizado = false));
                                            await chatController.getChat(
                                                authController.patient.value.cpf, widget.model.cpf);
                                            if (chatController.status.isSuccess) {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.w),
                                            child: Icon(
                                              Icons.arrow_right_alt_sharp,
                                              color: Colors.black26,
                                              size: 18.w,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class Bubble extends StatelessWidget {
  final AuthController authController = Get.find();
  final ChatModel chat;

  Bubble({this.chat});

  Widget build(BuildContext context) {
    bool isMe = chat.remetente == chat.pacienteCpf || chat.remetente == authController.patient.value.nome;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      padding: isMe ? EdgeInsets.only(left: 20.w) : EdgeInsets.only(right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
            children: <Widget>[
              if (!isMe)
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Colors.black12,
                  child: ClipOval(
                      child: Image(
                    image: AssetImage('assets/images/medical-team.png'),
                  )),
                ),
              if (chat.visualizado)
                Image.asset(
                  "assets/images/visualized.png",
                  color: RehabColors().mainColor,
                  height: 9.w,
                  width: 17.w,
                ),
              SizedBox(
                width: isMe ? 6.w : 10.w,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: isMe ? RehabColors().mainColor : Colors.black12,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10.r),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(0),
                          ),
                  ),
                  child: Text(
                    chat.mensagem,
                    textAlign: isMe ? TextAlign.start : TextAlign.start,
                    style: TextStyle(
                        fontSize: 14.w, color: isMe ? Colors.white : Colors.black38, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
