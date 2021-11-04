import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/ui/standard_widgets/standard_item_for_care_widget.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';

class NutritionalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      child: Column(
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
                          'Nutricionista:',
                          style: TextStyle(
                              color: RehabColors().mainColorHover, fontSize: 18.w, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Amanda da silva',
                          style: TextStyle(
                              color: RehabColors().mainColorHover, fontSize: 16.w, fontWeight: FontWeight.w400),
                        ),
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
                        Text(
                          'Segunda-feira, 10 de junho 2021',
                          style: TextStyle(
                              color: RehabColors().mainColorHover.withOpacity(0.8),
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Faltam 5 dias para o fim da dieta',
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
            height: 10.w,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                StandardItemForCareWidget("Arroz", "300g"),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Divider(
                    height: 1.w,
                    color: Colors.grey[400],
                  ),
                ),
                StandardItemForCareWidget("Feijão", "250g"),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Divider(
                    height: 1.w,
                    color: Colors.grey[400],
                  ),
                ),
                StandardItemForCareWidget("Pão", "Dois pães"),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Divider(
                    height: 1.w,
                    color: Colors.grey[400],
                  ),
                ),
                StandardItemForCareWidget("Salada", "100g"),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Divider(
                    height: 1.w,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
