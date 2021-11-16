import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/controller/auth_controller.dart';
import 'package:rehab_it/ui/controller/checkin_controller.dart';
import 'package:rehab_it/ui/model/checkin.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';
import 'package:rehab_it/utils/date_formatter.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timeago/timeago.dart' as timeago;

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  double _slider = 0;
  String _sliderLabel = '0';
  TextEditingController textEditingIncidentController = new TextEditingController();
  TextEditingController textEditingPressureController = new TextEditingController();
  TextEditingController textEditingSaturationController = new TextEditingController();
  TextEditingController textEditingWeatherController = new TextEditingController();
  TextEditingController textEditingFrequencyController = new TextEditingController();
  TextEditingController textEditingGlicemiaController = new TextEditingController();
  final CheckInController checkInController = Get.find();
  final AuthController authController = Get.find();
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    await checkInController.getIncidents(authController.patient.value.cpf);
    await checkInController.getIMonitoring(authController.patient.value.cpf);
  }

  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        checkInController,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView(
            shrinkWrap: true,
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
                            dateTimeAsStringNumeric(DateTime.now()),
                            style: TextStyle(color: Colors.black38, fontSize: 14.w),
                          ),
                          TextField(
                            controller: textEditingIncidentController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.warning_amber_outlined),
                              labelText: 'Incidente',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () async {
                            await checkInController.addIncident(Incident((b) => b
                              ..cpf = authController.patient.value.cpf
                              ..dtRelato = dateAsDBFormat(DateTime.now())
                              ..incidente = textEditingIncidentController.text));
                            await checkInController.getIncidents(authController.patient.value.cpf);
                            if (checkInController.status.isSuccess) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Get.back();
                            }
                          },
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
                            dateTimeAsStringNumeric(DateTime.now()),
                            style: TextStyle(color: Colors.black38, fontSize: 14.w),
                          ),
                          TextField(
                            controller: textEditingFrequencyController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.favorite_outline_rounded),
                              labelText: 'Frequência Cardíaca',
                            ),
                          ),
                          TextField(
                            controller: textEditingPressureController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.favorite_outline_rounded),
                              labelText: 'Pressão Arterial',
                            ),
                          ),
                          TextField(
                            controller: textEditingWeatherController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.wysiwyg_outlined),
                              labelText: 'Temperatura',
                            ),
                          ),
                          TextField(
                            controller: textEditingSaturationController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.wysiwyg_outlined),
                              labelText: 'Saturação',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () async {
                            await checkInController.addMonitoring(Monitoring((b) => b
                              ..seq = checkInController.monitoring[0].seq
                              ..cpf = authController.patient.value.cpf
                              ..freqCardiacaPre = textEditingFrequencyController.text
                              ..temperatura = textEditingWeatherController.text
                              ..data = dateAsDBFormat(DateTime.now())
                              ..saturacao = textEditingSaturationController.text
                              ..glicemia = textEditingGlicemiaController.text
                              ..bemEstar = int.tryParse(_sliderLabel)
                              ..pressao = textEditingPressureController.text));
                            await checkInController.getIMonitoring(authController.patient.value.cpf);
                            if (checkInController.status.isSuccess) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Get.back();
                            }
                          },
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
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
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
                      title: "Insira o nível de glicemia abaixo",
                      style: AlertStyle(
                          titleTextAlign: TextAlign.center,
                          titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                          buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                      content: Column(
                        children: <Widget>[
                          Text(
                            dateTimeAsStringNumeric(DateTime.now()),
                            style: TextStyle(color: Colors.black38, fontSize: 14.w),
                          ),
                          TextField(
                            controller: textEditingGlicemiaController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.medical_services_outlined),
                              labelText: 'Glicemia',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () async {
                            await checkInController.addMonitoring(Monitoring((b) => b
                              ..seq = checkInController.monitoring[0].seq
                              ..cpf = authController.patient.value.cpf
                              ..freqCardiacaPre = textEditingFrequencyController.text
                              ..temperatura = textEditingWeatherController.text
                              ..data = dateAsDBFormat(DateTime.now())
                              ..saturacao = textEditingSaturationController.text
                              ..glicemia = textEditingGlicemiaController.text
                              ..bemEstar = int.tryParse(_sliderLabel)
                              ..pressao = textEditingPressureController.text));
                            if (checkInController.status.isSuccess) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Get.back();
                            }
                          },
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
                          'Realizar checkin glicemia',
                          style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: RehabColors().mainColor.withOpacity(0.2)),
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
                              dateTimeAsStringNumeric(DateTime.now()),
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
                                      style:
                                          TextStyle(color: Colors.black54, fontSize: 12.w, fontWeight: FontWeight.w500),
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
                          onPressed: () async {
                            await checkInController.addMonitoring(Monitoring((b) => b
                              ..seq = checkInController.monitoring[0].seq
                              ..cpf = authController.patient.value.cpf
                              ..freqCardiacaPre = textEditingFrequencyController.text
                              ..temperatura = textEditingWeatherController.text
                              ..data = dateAsDBFormat(DateTime.now())
                              ..saturacao = textEditingSaturationController.text
                              ..glicemia = textEditingGlicemiaController.text
                              ..bemEstar = int.tryParse(_sliderLabel)
                              ..pressao = textEditingPressureController.text));
                            await checkInController.getIMonitoring(authController.patient.value.cpf);
                            if (checkInController.status.isSuccess) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Get.back();
                            }
                          },
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
              SizedBox(
                height: 10.w,
              ),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.incidents.length,
                    itemBuilder: (context, index) {
                      return incident(checkInController.incidents[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.pressao.length,
                    itemBuilder: (context, index) {
                      return monitoring(checkInController.pressao[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.freqCardiacaPre.length,
                    itemBuilder: (context, index) {
                      return frequency(checkInController.freqCardiacaPre[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.saturacao.length,
                    itemBuilder: (context, index) {
                      return saturation(checkInController.pressao[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.temperatura.length,
                    itemBuilder: (context, index) {
                      return weather(checkInController.pressao[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.glicemia.length,
                    itemBuilder: (context, index) {
                      return glicemia(checkInController.glicemia[index]);
                    },
                  )),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkInController.bemEstar.length,
                    itemBuilder: (context, index) {
                      return bemEstar(checkInController.bemEstar[index]);
                    },
                  )),
              SizedBox(
                height: 10.w,
              )
            ],
          ),
        ));
  }

  Widget monitoring(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Batimentos - ${model.pressao}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget frequency(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Frequencia cardíaca - ${model.freqCardiacaPre}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget saturation(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Saturação - ${model.saturacao}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget weather(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Temperatura - ${model.temperatura}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bemEstar(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Nivel bem-estar - ${model.bemEstar}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget glicemia(MonitoringModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
                'Glicemia - ${model.glicemia}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.data)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget incident(IncidentModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: RehabColors().warningColor.withOpacity(0.2)),
            child: Icon(
              Icons.warning_amber_outlined,
              color: RehabColors().warningColor,
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
                'Incidente - ${model.incidente}',
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
                    dateTimeAsStringNumeric(DateTime.parse(model.dtRelato)),
                    style: TextStyle(color: Colors.black38, fontSize: 14.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
