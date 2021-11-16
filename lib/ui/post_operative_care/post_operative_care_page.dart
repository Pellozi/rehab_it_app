import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rehab_it/ui/controller/auth_controller.dart';
import 'package:rehab_it/ui/controller/care_controller.dart';
import 'package:rehab_it/ui/post_operative_care/physical_page.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rehab_it/utils/date_formatter.dart';
import 'package:toggle_bar/toggle_bar.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';

import 'general_page.dart';
import 'medicines_page.dart';
import 'nutritional_page.dart';

class PostOperativePage extends StatefulWidget {
  @override
  _PostOperativePageState createState() => _PostOperativePageState();
}

class _PostOperativePageState extends State<PostOperativePage> {
  List<String> labels = ["Gerais", "Medicação", "Atividade física", "Alimentação"];
  PageController _pageController;
  var toggleIndex = 0;
  final CareController careController = Get.put(CareController());
  final AuthController authController = Get.find();
  @override
  void initState() {
    _pageController = PageController();
    careController.getCares(authController.patient.value.cpf);
    careController.getCareExercise(authController.patient.value.cpf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        careController,
        Column(
          children: [
            Container(
              height: 75.w,
              child: ToggleBar(
                selectedTabColor: Colors.white,
                backgroundColor: RehabColors().mainColor.withOpacity(0.9),
                selectedTextColor: RehabColors().mainColor,
                textColor: Colors.white,
                labelTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 11.w,
                ),
                labels: labels,
                onSelectionUpdated: (index) {
                  toggleIndex = index;
                  _pageController.jumpToPage(index);
                },
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                pageSnapping: false,
                onPageChanged: (index) {
                  setState(() => toggleIndex = index);
                },
                children: <Widget>[
                  GeneralPage(),
                  MedicinesPage(),
                  PhysicalPage(),
                  NutritionalPage(),
                ],
              ),
            ),
          ],
        ));
  }
}
