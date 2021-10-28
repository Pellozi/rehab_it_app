import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/home_page.dart';
import 'package:rehab_it/utils/colors.dart';

class PasswordStepBody extends StatefulWidget {
  final int studentId;
  final bool notSetSheetDetailController;
  PasswordStepBody({this.studentId, this.notSetSheetDetailController = true});
  @override
  _PasswordStepBodyState createState() => _PasswordStepBodyState();
}

class _PasswordStepBodyState extends State<PasswordStepBody> {
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingConfirmController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool simpleValidate = true;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 100.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.w,
                ),
                Text(
                  'Por favor, escolha uma senha para o app',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 25.w,
                ),
                TextField(
                  controller: textEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'senha',
                  ),
                ),
                SizedBox(
                  height: 15.w,
                ),
                TextField(
                  controller: textEditingConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'Confirmar senha',
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Get.to(HomePage(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    decoration:
                        BoxDecoration(color: RehabColors().mainColor, borderRadius: BorderRadius.circular(10.r)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18.w, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
