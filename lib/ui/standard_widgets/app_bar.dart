import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/post_operative_care/post_operative_care_page.dart';
import 'package:rehab_it/ui/profile/profile_page.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StandardAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool hasBackButton;
  final Function onBackPressed;
  StandardAppBarWidget({this.title, this.actions, this.hasBackButton = false, this.onBackPressed});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed == null
          ? () {
              Navigator.pop(context);
              FocusScope.of(context).requestFocus(new FocusNode());
              return;
            }
          : onBackPressed,
      child: AppBar(
        title: Text(
          'Rehab.it',
          style: TextStyle(color: Colors.white, fontSize: 20.w, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leadingWidth: 70.w,
        toolbarHeight: 70.w,
        backgroundColor: RehabColors().mainColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            hasBackButton ? Icons.arrow_back_rounded : Icons.person_outline,
            size: 24.w,
            color: Colors.white,
          ),
          onPressed: () {
            if (hasBackButton) {
              Get.back();
              return;
            }
            Get.to(ProfilePage());
          },
        ),
        actions: [
//          Container(
//            height: 25.w,
//            width: 29.w,
//            margin: EdgeInsets.only(right: 20.w),
//            child: Stack(
//              children: [
//                Positioned.fill(
//                  child: IconButton(
//                    icon: Icon(
//                      Icons.notifications_none_rounded,
//                      size: 24.w,
//                      color: Colors.white,
//                    ),
//                    onPressed: () {
//                      Alert(
//                          context: context,
//                          title: "Noticações",
//                          style: AlertStyle(
//                              titleTextAlign: TextAlign.center,
//                              titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
//                              buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
//                          desc: 'Novos cuidados foram cadastrados',
//                          buttons: [
//                            DialogButton(
//                              onPressed: () {
//                                Get.back();
//                                Get.to(Scaffold(
//                                    appBar: StandardAppBarWidget(
//                                      hasBackButton: true,
//                                    ),
//                                    body: PostOperativePage()));
//                              },
//                              child: Text(
//                                "Ver cuidados",
//                                style: TextStyle(color: Colors.white, fontSize: 16.w),
//                              ),
//                              color: RehabColors().mainColor,
//                            )
//                          ]).show();
//                    },
//                  ),
//                ),
//                Positioned(
//                  top: 15,
//                  right: 1,
//                  child: Container(
//                    height: 8.w,
//                    width: 8.w,
//                    decoration: BoxDecoration(color: RehabColors().cautionColor, shape: BoxShape.circle),
//                  ),
//                )
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0.h);
}
