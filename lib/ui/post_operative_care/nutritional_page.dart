import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/controller/care_controller.dart';
import 'package:rehab_it/ui/standard_widgets/standard_item_for_care_widget.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rehab_it/utils/date_formatter.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';

class NutritionalPage extends StatelessWidget {
  final CareController careController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: Column(
        children: [
          if (careController.listNutritional.length > 0)
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
                          if (careController.listNutritional.length > 0)
                            Obx(() => Text(
                                  tpEspecialista(careController.listNutritional[0].tpEspecialista),
                                  style: TextStyle(
                                      color: RehabColors().mainColorHover, fontSize: 18.w, fontWeight: FontWeight.w500),
                                )),
                          SizedBox(width: 6.w),
                          if (careController.listNutritional.length > 0)
                            Obx(() => Text(
                                  careController.listNutritional[0].nomeEspecialista,
                                  style: TextStyle(
                                      color: RehabColors().mainColorHover, fontSize: 16.w, fontWeight: FontWeight.w400),
                                )),
                        ],
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        children: [
                          Text(
                            'Dieta desde:',
                            style: TextStyle(
                                color: RehabColors().mainColorHover.withOpacity(0.8),
                                fontSize: 14.w,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 6.w),
                          if (careController.listNutritional.length > 0)
                            Obx(() => Text(
                                  dateAsStringLongMonth(DateTime.parse(careController.listNutritional[0].dtPublicacao)),
                                  style: TextStyle(
                                      color: RehabColors().mainColorHover.withOpacity(0.8),
                                      fontSize: 13.w,
                                      fontWeight: FontWeight.w400),
                                )),
                        ],
                      ),
                      SizedBox(height: 10.w),
                      if (careController.listNutritional.length > 0)
                        Obx(() => Text(
                              'Faltam ${DateTime.tryParse(careController.listNutritional[0].dtDuracao).difference(DateTime.tryParse(careController.listNutritional[0].dtPublicacao)).inDays} dias para o fim da dieta',
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
            height: 10.w,
          ),
          Expanded(
              child: Obx(
            () => ListView(
              shrinkWrap: true,
              children: <Widget>[
                ...careController.listNutritional.map((element) => StandardItemForCareWidget(
                      "Higienizar a área do curativo 3x ao dia",
                      "",
                      careModel: element,
                    )),
              ],
            ),
          ))
        ],
      ),
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
