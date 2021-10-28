import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'dashboard_chart_widget.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [_buildHeader(), _buildCardHeader(), _buildBody()],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0.w,
      right: 0.w,
      left: 0.w,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: RehabColors().mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0.w),
            bottomRight: Radius.circular(40.0.w),
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Você não está se sentindo bem?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Se você se sentir mal com algum sintoma adverso, ligue ou envie uma mensagem de texto imediatamente para obter ajuda',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 15.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await FlutterPhoneDirectCaller.callNumber('192');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 40.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Ligar',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {
                        Alert(
                            context: context,
                            title: "Descreva o seu problema abaixo",
                            style: AlertStyle(
                                titleTextAlign: TextAlign.center,
                                titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                                buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '07/05/2021 as 14:00',
                                  style: TextStyle(color: Colors.black38, fontSize: 14.w),
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.medical_services_outlined),
                                    labelText: 'Observações',
                                  ),
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Enviar",
                                  style: TextStyle(color: Colors.white, fontSize: 16.w),
                                ),
                                color: RehabColors().mainColor,
                              )
                            ]).show();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Mensagem',
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 50.w),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return Positioned(
        top: 175.w,
        left: 25.w,
        right: 25.w,
        child: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 15.w, bottom: 20.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Cirurgia no coração',
                    style: TextStyle(color: Colors.black54, fontSize: 20.w, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Text(
                        'Medico:',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'João',
                        style: TextStyle(color: Colors.black38, fontSize: 13.w, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Text(
                        'Realizada:',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Segunda-feira, 10 de junho 2021',
                        style: TextStyle(color: Colors.black38, fontSize: 13.w, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    '15 dias de recuperação',
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildBody() {
    return Positioned(
      bottom: 0,
      top: 350,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 60.w),
                child: Container(
                  height: 180.w,
                  child: DashboardChartWidget(values: [
                    [5, 12, 3],
                    [100, 110, 250],
                    [3, 7, 10]
                  ], colors: [
                    Colors.blue,
                    Colors.red,
                    Colors.lightGreenAccent
                  ], dates: [
                    DateTime.now(),
                    DateTime.now(),
                    DateTime.now()
                  ], titles: [
                    "pressão",
                    "glicose",
                    "bem-estar"
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
