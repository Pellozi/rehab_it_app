import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/ui/login/password_page.dart';
import 'package:rehab_it/utils/colors.dart';

class EmailStepBody extends StatefulWidget {
  final int studentId;
  final bool notSetSheetDetailController;
  EmailStepBody({this.studentId, this.notSetSheetDetailController = true});
  @override
  _EmailStepBodyState createState() => _EmailStepBodyState();
}

class _EmailStepBodyState extends State<EmailStepBody> {
  TextEditingController textEditingController = new TextEditingController();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.w,
                ),
                Text(
                  'Por favor insira seu cpf para entrar no aplicativo',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black54, fontSize: 24.w, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 25.w,
                ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'CPF',
                  ),
                ),
                SizedBox(
                  height: 50.w,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Get.to(PasswordStepBody(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    decoration:
                        BoxDecoration(color: RehabColors().mainColor, borderRadius: BorderRadius.circular(10.r)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Proxímo',
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