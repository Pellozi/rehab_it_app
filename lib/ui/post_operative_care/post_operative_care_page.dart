import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/ui/post_operative_care/physical_page.dart';
import 'package:rehab_it/utils/colors.dart';
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
  List<String> labels = ["Gerais", "Medicação", "Físico", "Alimentação"];
  PageController _pageController;
  var toggleIndex = 0;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleBar(
          selectedTabColor: Colors.white,
          backgroundColor: RehabColors().mainColor.withOpacity(0.9),
          selectedTextColor: RehabColors().mainColor,
          textColor: Colors.white,
          labelTextStyle: TextStyle(color: Colors.black, fontSize: 12.4.w),
          labels: labels,
          onSelectionUpdated: (index) {
            toggleIndex = index;
            _pageController.jumpToPage(index);
          },
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
    );
  }
}
