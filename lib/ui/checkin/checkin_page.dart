import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  double _slider = 0;
  String _sliderLabel = '0';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: ListView(
        children: [
          SizedBox(
            height: 20.w,
          ),
          InkWell(
            onTap: () {
              Alert(
                  context: context,
                  title: "Descreva abaixo o incidente ocorrido",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: Column(
                    children: <Widget>[
                      Text(
                        '07/05/2021 as 14:00',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.warning_amber_outlined),
                          labelText: 'Incidente',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Relatar incidente",
                        style: TextStyle(color: Colors.white, fontSize: 16.w),
                      ),
                      color: RehabColors().warningColor,
                    )
                  ]).show();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: RehabColors().warningColor,
                  borderRadius: BorderRadius.circular(20.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Relatar incidente',
                      style: TextStyle(color: Colors.white, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.white,
                    size: 22.w,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          InkWell(
            onTap: () {
              Alert(
                  context: context,
                  title: "Insira seus sinais vitais abaixo",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: Column(
                    children: <Widget>[
                      Text(
                        '07/05/2021 as 14:00',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.favorite_outline_rounded),
                          labelText: 'Frequência Cardíaca',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.favorite_outline_rounded),
                          labelText: 'Pressão Arterial',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.wysiwyg_outlined),
                          labelText: 'Temperatura',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.wysiwyg_outlined),
                          labelText: 'Saturação',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Realizar checkin",
                        style: TextStyle(color: Colors.white, fontSize: 16.w),
                      ),
                      color: RehabColors().mainColor,
                    )
                  ]).show();
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ]),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Realizar checkin sinais vitais',
                      style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
                    child: Icon(
                      Icons.check,
                      color: RehabColors().mainColor,
                      size: 18.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          InkWell(
            onTap: () {
              Alert(
                  context: context,
                  title: "Insira o nível de glicose abaixo",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: Column(
                    children: <Widget>[
                      Text(
                        '07/05/2021 as 14:00',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.medical_services_outlined),
                          labelText: 'Glicose',
                        ),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Realizar checkin",
                        style: TextStyle(color: Colors.white, fontSize: 16.w),
                      ),
                      color: RehabColors().mainColor,
                    )
                  ]).show();
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ]),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Realizar checkin glicose',
                      style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
                    child: Icon(
                      Icons.check,
                      color: RehabColors().mainColor,
                      size: 18.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          InkWell(
            onTap: () {
              Alert(
                  context: context,
                  title: "Queremos saber como voce está se sentindo",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: StatefulBuilder(builder: (context, state) {
                    return Column(
                      children: <Widget>[
                        Text(
                          '07/05/2021 as 14:00',
                          style: TextStyle(color: Colors.black38, fontSize: 14.w),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.event_note_sharp),
                            labelText: 'observações',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'De 1 a 10 como está se sentindo: ',
                                  style: TextStyle(color: Colors.black54, fontSize: 12.w, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  _sliderLabel,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: RehabColors().mainColor, fontSize: 12.w, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 290.w,
                          child: CupertinoSlider(
                            activeColor: RehabColors().mainColor.withOpacity(0.88),
                            max: 10,
                            min: 0,
                            thumbColor: RehabColors().mainColor,
                            value: _slider,
                            onChanged: (val) {
                              state(() {
                                setState(() {
                                  _slider = val;
                                  _sliderLabel = val.toStringAsFixed(0);
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Realizar checkin",
                        style: TextStyle(color: Colors.white, fontSize: 16.w),
                      ),
                      color: RehabColors().mainColor,
                    )
                  ]).show();
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ]),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Realizar checkin de bem-estar',
                      style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: RehabColors().cautionColor.withOpacity(0.5)),
                    child: Icon(
                      Icons.access_time,
                      color: RehabColors().cautionColor,
                      size: 18.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Text(
              'Realizados',
              style: TextStyle(color: Colors.black54, fontSize: 14.w),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.w), boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ]),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
                  child: Icon(
                    Icons.check,
                    color: RehabColors().mainColor,
                    size: 25.w,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Batimentos - 12/10',
                      style: TextStyle(color: Colors.black54, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          height: 5.w,
                          width: 5.w,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          '1 dia atrás',
                          style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
                  child: Icon(
                    Icons.check,
                    color: RehabColors().mainColor,
                    size: 25.w,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Glicose - 100mg/dl',
                      style: TextStyle(color: Colors.black54, fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          height: 5.w,
                          width: 5.w,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          '1 dia atrás',
                          style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
