import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/ui/standard_widgets/standard_item_for_care_widget.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';

class GeneralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: ListView(
        children: [
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
                        Text(
                          'Médico:',
                          style: TextStyle(
                              color: RehabColors().mainColorHover, fontSize: 18.w, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'João Rodrigues',
                          style: TextStyle(
                              color: RehabColors().mainColorHover, fontSize: 16.w, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        Text(
                          'Receita desde:',
                          style: TextStyle(
                              color: RehabColors().mainColorHover.withOpacity(0.8),
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Segunda-feira, 20 de junho 2021',
                          style: TextStyle(
                              color: RehabColors().mainColorHover.withOpacity(0.8),
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Faltam 5 dias para o fim dos medicamentos',
                      style: TextStyle(
                          color: RehabColors().mainColorHover.withOpacity(0.8),
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.w,
          ),
          StandardItemForCareWidget(
            "Trocar o curativo 1x ao dia",
            "",
            hasQuantity: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Divider(
              height: 1.w,
              color: Colors.grey[400],
            ),
          ),
          StandardItemForCareWidget(
            "Higienizar a área do curativo 3x ao dia",
            "",
            hasQuantity: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Divider(
              height: 1.w,
              color: Colors.grey[400],
            ),
          ),
          StandardItemForCareWidget(
            "Medir os batimentos 1x ao dia",
            "",
            hasQuantity: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Divider(
              height: 1.w,
              color: Colors.grey[400],
            ),
          ),
          StandardItemForCareWidget(
            "Medir glicose 1x ao dia",
            "",
            hasQuantity: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Divider(
              height: 1.w,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
