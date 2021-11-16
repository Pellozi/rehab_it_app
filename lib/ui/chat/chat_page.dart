import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/ui/controller/doctor_controller.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/chat/chat_conversation_page.dart';

class ChatPage extends StatelessWidget {
  final DoctorController doctorController = Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        doctorController,
        Padding(
          padding: EdgeInsets.only(top: 30.w),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: doctorController.listDoctors.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Get.to(ChatConversationPage(doctorController.listDoctors[index]),
                          transition: Transition.rightToLeft);
                    },
                    child: chatLisItem(doctorController.listDoctors[index]));
              }),
        ));
  }

  Widget chatLisItem(DoctorModel model) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
      child: Row(
        children: [
          CircleAvatar(
              child: ClipOval(
                  child: Image(
            image: AssetImage('assets/images/medical-team.png'),
          ))),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tpEspecialista(model.tpEspecialista),
                style: TextStyle(color: Colors.black54, fontSize: 18.w, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                model.nome,
                style: TextStyle(color: Colors.black38, fontSize: 16.w, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String tpEspecialista(String tp) {
    if (tp == 'edFisico') return 'Educador físico';
    if (tp == 'medico ') return 'Médico';
    if (tp == 'enfermeiro ') return 'Enfermeiro';
    if (tp == 'nutricionista ') return 'Nutricionista';
    return 'Médico';
  }
}
