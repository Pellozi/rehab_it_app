import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/controller/care_controller.dart';
import 'package:rehab_it/ui/standard_widgets/standard_item_for_care_widget.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rehab_it/utils/date_formatter.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';

class PhysicalPage extends StatelessWidget {
  final CareController careController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: Obx(() => ListView(
            children: [
              if (careController.listExercise.length > 0)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  decoration: BoxDecoration(
                    color: RehabColors().mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Obx(() => Text(
                                    tpEspecialista(careController.listExercise[0].tpEspecialista),
                                    style: TextStyle(
                                        color: RehabColors().mainColorHover,
                                        fontSize: 18.w,
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(width: 6.w),
                              Obx(() => Text(
                                    careController.listExercise[0].nomeEspecialista,
                                    style: TextStyle(
                                        color: RehabColors().mainColorHover,
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ],
                          ),
                          SizedBox(height: 10.w),
                          if (careController.listExercise.length > 0)
                            Row(
                              children: [
                                Text(
                                  'Exercicios desde:',
                                  style: TextStyle(
                                      color: RehabColors().mainColorHover.withOpacity(0.8),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 6.w),
                                Obx(() => Text(
                                      dateAsStringLongMonth(
                                          DateTime.parse(careController.listExercise[0].dtPublicacao)),
                                      style: TextStyle(
                                          color: RehabColors().mainColorHover.withOpacity(0.8),
                                          fontSize: 13.w,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ],
                            ),
                          SizedBox(height: 10.w),
                          if (careController.listExercise.length > 0)
                            Obx(() => Text(
                                  'Faltam ${DateTime.tryParse(careController.listExercise[0].dtDuracao).difference(DateTime.tryParse(careController.listExercise[0].dtPublicacao)).inDays} dias para o fim dos exercícios',
                                  style: TextStyle(
                                      color: RehabColors().mainColorHover.withOpacity(0.8),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500),
                                )),
                        ],
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: 15.w,
              ),
              SizedBox(
                height: 10.w,
              ),
              ...careController.listExercise.map((element) => StandardItemForCareExerciseWidget(
                    element,
                  )),
            ],
          )),
    );
  }

  String tpEspecialista(String tp) {
    if (tp == '2') return 'Educador físico:';
    if (tp == '3') return 'Médico:';
    if (tp == '4') return 'Enfermeiro:';
    if (tp == '1') return 'Nutricionista:';
    return 'Médico:';
  }
}
