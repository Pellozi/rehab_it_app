import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/ui/controller/auth_controller.dart';
import 'package:rehab_it/ui/model/patient.dart';
import 'package:rehab_it/ui/standard_widgets/rehab_obx_widget.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController authController = Get.find();

  TextEditingController textEditingNameController = new TextEditingController(text: '');

  TextEditingController textEditingHeightController = new TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return RehabObxWidget(
        authController,
        Scaffold(
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
                              labelText: 'Nome',
                            ),
                            controller: textEditingNameController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.height),
                              labelText: 'Altura(m)',
                            ),
                            controller: textEditingHeightController,
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () async {
                            Get.back();
                            await authController.editPatient(Patient((b) => b
                              ..cpf = authController.patient.value.cpf
                              ..email = authController.patient.value.email
                              ..nome = textEditingNameController.text.isNotEmpty
                                  ? textEditingNameController.text
                                  : authController.patient.value.nome
                              ..altura = textEditingHeightController.text.isNotEmpty
                                  ? double.tryParse(textEditingHeightController.text)
                                  : authController.patient.value.altura
                              ..evento = authController.patient.value.evento
                              ..tratamento = authController.patient.value.tratamento
                              ..password = authController.patient.value.password
                              ..fumante = false
                              ..diabetico = false
                              ..habilitado = true
                              ..respCadastro = authController.patient.value.respCadastro
                              ..nrDias = authController.patient.value.nrDias));
                            await authController.userInfo(authController.patient.value.cpf);
                            if (authController.status.isSuccess) {
                              FocusScope.of(context).requestFocus(new FocusNode());
                            }
                          },
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
              Obx(() => Text(
                    authController.patient.value.nome,
                    style: TextStyle(color: Colors.grey[800], fontSize: 20.w),
                  )),
              SizedBox(
                height: 10.w,
              ),
              Obx(() => Text(
                    '${authController.patient.value.nrDias} Dias de Recuperação',
                    style: TextStyle(color: Colors.black54, fontSize: 16.w),
                  )),
              SizedBox(
                height: 10.w,
              ),
              Obx(() => Text(
                    authController.patient.value.altura.toStringAsPrecision(2),
                    style: TextStyle(color: Colors.black54, fontSize: 16.w),
                  )),
            ],
          ),
        ));
  }
}
