import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rehab_it/ui/controller/auth_controller.dart';
import 'package:rehab_it/ui/controller/chat_controller.dart';
import 'package:rehab_it/ui/controller/checkin_controller.dart';
import 'package:rehab_it/ui/model/chat.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';
import 'package:rehab_it/utils/date_formatter.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'dashboard_chart_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthController authController = Get.find();
  final ChatController chatController = Get.put(ChatController());
  final CheckInController checkInController = Get.put(CheckInController());
  final TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    init();
    initializeDateFormatting("pt_BR", null);
    timeago.setLocaleMessages('pt_br_short', PtBrShortMessagesModified());
    super.initState();
  }

  Future<void> init() async {
    await checkInController.getIncidents(authController.patient.value.cpf);
    await checkInController.getIncidents(authController.patient.value.cpf);
    await checkInController.getIMonitoring(authController.patient.value.cpf);
  }

  List<DateTime> getDatesAsList() {
    List<DateTime> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(DateTime.tryParse(exerciseHistory.data));
    });
    return result;
  }

  List<double> getPressaoAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.pressao));
    });
    return result;
  }

  List<double> getBemAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.temperatura));
    });
    return result;
  }

  List<double> getGlicemiaAsList() {
    List<double> result = new List();
    checkInController.monitoring.forEach((exerciseHistory) {
      result.add(double.tryParse(exerciseHistory.freqCardiacaPre));
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        checkInController,
        Column(
          children: <Widget>[
            Expanded(
              child: Obx(
                () => Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildHeader(),
                    _buildCardHeader(),
                    if (checkInController.monitoring.length > 0) _buildBody()
                  ],
                ),
              ),
            )
          ],
        ));
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
                  'Não está se sentindo bem?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Caso esteja sentindo dor ou desconforto no peito, busque ajuda. ',
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
                                  dateTimeAsStringNumeric(DateTime.now()),
                                  style: TextStyle(color: Colors.black38, fontSize: 14.w),
                                ),
                                TextField(
                                  controller: textEditingController,
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
                                onPressed: () async {
                                  Get.back();
                                  await chatController.sendMessage(Chat((b) => b
                                    ..especialistaCpf = 'admin'
                                    ..pacienteCpf = authController.patient.value.cpf
                                    ..mensagem = textEditingController.text
                                    ..destinatario = authController.patient.value.cpf
                                    ..remetente = authController.patient.value.cpf
                                    ..visualizado = false));
                                  if (chatController.status.isSuccess) {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                  }
                                },
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
                  Obx(() => Text(
                        authController.patient.value.tratamento ?? '',
                        style: TextStyle(color: Colors.black54, fontSize: 20.w, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Text(
                        'Responsaável:',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 6.w),
                      Obx(() => Text(
                            authController.patient.value.nomeEspecialista ?? '',
                            style: TextStyle(color: Colors.black38, fontSize: 13.w, fontWeight: FontWeight.w400),
                          )),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Obx(() => Row(
                        children: [
                          Text(
                            'Entrada:',
                            style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 6.w),
                          if (authController.patient.value.dtInicio != null &&
                              authController.patient.value.dtInicio.isNotEmpty)
                            Obx(() => Text(
                                  dateAsStringLongMonth(DateTime.tryParse(authController.patient.value.dtInicio)),
                                  style: TextStyle(color: Colors.black38, fontSize: 13.w, fontWeight: FontWeight.w400),
                                )),
                          if (authController.patient.value.dtInicio == null ||
                              authController.patient.value.dtInicio.isEmpty)
                            Text(
                              dateAsStringLongMonth(DateTime.now()),
                              style: TextStyle(color: Colors.black38, fontSize: 13.w, fontWeight: FontWeight.w400),
                            )
                        ],
                      )),
                  SizedBox(height: 10.w),
                  Obx(() => Text(
                        '${authController.patient.value.nrDias} dias de recuperação',
                        style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                      )),
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
                  child: DashboardChartWidget(
                      values: [getPressaoAsList(), getBemAsList(), getGlicemiaAsList()],
                      colors: [Colors.blue, Colors.red, Colors.lightGreenAccent],
                      dates: getDatesAsList(),
                      titles: ["Batimentos", "Temperatura", "Saturação"]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
