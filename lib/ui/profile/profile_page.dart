import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rehab.it',
          style: TextStyle(color: Colors.white, fontSize: 20.w, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        centerTitle: true,
        leadingWidth: 50.w,
        toolbarHeight: 50.w,
        backgroundColor: RehabColors().mainColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 24.w,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 24.w,
              color: Colors.white,
            ),
            onPressed: () {
              Alert(
                  context: context,
                  title: "Edite as suas informações abaixo",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Marcos',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.location_on),
                          labelText: 'Rua marechal deodoro',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.line_weight),
                          labelText: '67kg',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.height),
                          labelText: '1,75',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Editar",
                        style: TextStyle(color: Colors.white, fontSize: 16.w),
                      ),
                      color: RehabColors().mainColor,
                    )
                  ]).show();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 180.w,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 120.w,
                  color: RehabColors().mainColor,
                ),
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {},
                    child: CircleAvatar(
                        radius: 73.w,
                        child: ClipOval(
                            child: Image(
                          image: AssetImage('assets/images/patient.png'),
                        ))),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            'Marcos de Lima',
            style: TextStyle(color: Colors.grey[800], fontSize: 20.w),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            'Rua marechal deodoro, 210',
            style: TextStyle(color: Colors.black54, fontSize: 16.w),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            'peso 67Kg - 1,75 de altura',
            style: TextStyle(color: Colors.black54, fontSize: 16.w),
          ),
        ],
      ),
    );
  }
}
