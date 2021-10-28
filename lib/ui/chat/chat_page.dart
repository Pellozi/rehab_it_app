import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/chat/chat_conversation_page.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.w),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Get.to(ChatConversationPage(), transition: Transition.rightToLeft);
                },
                child: chatLisItem(index));
          }),
    );
  }

  Widget chatLisItem(int index) {
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
              if (index == 0) ...[
                Text(
                  'Educador físico',
                  style: TextStyle(color: Colors.black54, fontSize: 18.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  'Marcelo',
                  style: TextStyle(color: Colors.black38, fontSize: 16.w, fontWeight: FontWeight.w400),
                ),
              ],
              if (index == 1) ...[
                Text(
                  'Nutricionista',
                  style: TextStyle(color: Colors.black54, fontSize: 18.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text('Amanda', style: TextStyle(color: Colors.black38, fontSize: 16.w, fontWeight: FontWeight.w400)),
              ],
              if (index == 2) ...[
                Text(
                  'Médico',
                  style: TextStyle(color: Colors.black54, fontSize: 18.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text('João', style: TextStyle(color: Colors.black38, fontSize: 16.w, fontWeight: FontWeight.w400)),
              ],
              if (index == 3) ...[
                Text(
                  'Enfermeira',
                  style: TextStyle(color: Colors.black54, fontSize: 18.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text('Ana', style: TextStyle(color: Colors.black38, fontSize: 16.w, fontWeight: FontWeight.w400)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
