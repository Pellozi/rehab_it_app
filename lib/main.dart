import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/home_page.dart';
import 'package:rehab_it/ui/login/login_page.dart';
import 'package:rehab_it/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primaryColor: RehabColors().mainColor,
        ),
        debugShowCheckedModeBanner: false,
        home: ScreenUtilInit(
          designSize: Size(375, 812),
          builder: () => EmailStepBody(),
        ));
  }
}
