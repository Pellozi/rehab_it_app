import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/ui/standard_widgets/app_bar.dart';
import 'package:rehab_it/utils/colors.dart';

class ChatConversationPage extends StatefulWidget {
  @override
  _ChatConversationPageState createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  TextEditingController _textEditingController = new TextEditingController();
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 10), () => _controller.jumpTo(_controller.position.maxScrollExtent));
    return Scaffold(
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
                            child: ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {}, child: Bubble(isMe: index == 4 || index == 3 ? true : false));
                                }),
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
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: Colors.black38.withOpacity(0.7),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 13.w, color: Colors.black26, fontWeight: FontWeight.w500),
                                        hintText: 'Escreva um comentário',
                                        hintMaxLines: 2,
                                      ),
                                      style:
                                          TextStyle(fontSize: 13.w, color: Colors.black26, fontWeight: FontWeight.w500),
                                      controller: _textEditingController,
                                      maxLines: null,
                                    ),
                                  ),
                                  Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () async {},
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
        ));
  }
}

class Bubble extends StatelessWidget {
  final bool isMe;

  Bubble({this.isMe});

  Widget build(BuildContext context) {
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
              if (isMe)
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
                    'lorem ipsum sit amet',
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
