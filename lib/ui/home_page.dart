import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/ui/post_operative_care/post_operative_care_page.dart';
import 'package:rehab_it/ui/standard_widgets/app_bar.dart';
import 'package:rehab_it/utils/colors.dart';

import 'chat/chat_page.dart';
import 'checkin/checkin_page.dart';
import 'dashboard/dashboard_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a fi
  PageController _pageController;
  Animation<double> animation;
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.person_outline,
    Icons.add_box_outlined,
    Icons.chat,
  ];

  final iconText = <String>[
    'Início',
    'Cuidados',
    'Adicionar alterções',
    'Chat',
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBarWidget(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              pageSnapping: false,
              onPageChanged: (index) {
                setState(() => _bottomNavIndex = index);
              },
              children: <Widget>[
                DashboardPage(),
                PostOperativePage(),
                CheckInPage(),
                ChatPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 15.w,
        items: [Icons.home, Icons.event_note, Icons.fact_check_outlined, Icons.chat]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.0.w,
                        horizontal: 16.0.w,
                      ),
                      decoration: BoxDecoration(
                        color: _bottomNavIndex == key ? RehabColors().mainColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}
