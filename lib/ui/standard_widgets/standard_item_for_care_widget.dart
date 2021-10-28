import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';

class StandardItemForCareWidget extends StatelessWidget {
  final String ingredientName;
  final String quantity;
  final bool hasQuantity;
  StandardItemForCareWidget(this.ingredientName, this.quantity, {this.hasQuantity = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 10.w,
              ),
              Text(
                ingredientName,
                style: TextStyle(color: Colors.black38, fontSize: 14.w),
              )
            ],
          ),
          if (hasQuantity)
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
              decoration: BoxDecoration(color: RehabColors().mainColor, borderRadius: BorderRadius.circular(20.w)),
              child: Text(
                quantity,
                style: TextStyle(color: Colors.white, fontSize: 14.w),
              ),
            )
        ],
      ),
    );
  }
}
