import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehab_it/ui/controller/care_controller.dart';
import 'package:rehab_it/utils/screen_util/flutter_screenutil.dart';
import 'package:rehab_it/utils/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StandardItemForCareWidget extends StatelessWidget {
  final CareModel careModel;
  final String ingredientName;
  final String quantity;
  final bool hasQuantity;

  StandardItemForCareWidget(this.ingredientName, this.quantity, {this.hasQuantity = true, this.careModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    careModel.descricao,
                    style: TextStyle(color: Colors.black38, fontSize: 14.w),
                  )
                ],
              ),
              if (hasQuantity)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                  decoration: BoxDecoration(color: RehabColors().mainColor, borderRadius: BorderRadius.circular(20.w)),
                  child: Text(
                    careModel.quantidade,
                    style: TextStyle(color: Colors.white, fontSize: 14.w),
                  ),
                )
            ],
          ),
        ),
        if (careModel.observacao != null && careModel.observacao.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            decoration: BoxDecoration(
              color: RehabColors().mainColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  Icons.wysiwyg,
                  color: RehabColors().mainColor,
                  size: 25.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    careModel.observacao,
                    style: TextStyle(
                        color: RehabColors().mainColor.withOpacity(0.7), fontSize: 14.w, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10.w),
          child: Divider(
            height: 1.w,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

class StandardItemForCareExerciseWidget extends StatefulWidget {
  final CareExerciseModel careModel;

  StandardItemForCareExerciseWidget(this.careModel);

  @override
  State<StandardItemForCareExerciseWidget> createState() => _StandardItemForCareExerciseWidgetState();
}

class _StandardItemForCareExerciseWidgetState extends State<StandardItemForCareExerciseWidget> {
  double _slider = 0;
  final CareController careController = Get.find();
  String _sliderLabel = '0';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
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
                      widget.careModel.descricao,
                      style: TextStyle(color: Colors.black38, fontSize: 14.w),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                  decoration: BoxDecoration(color: RehabColors().mainColor, borderRadius: BorderRadius.circular(20.w)),
                  child: Text(
                    widget.careModel.quantidade,
                    style: TextStyle(color: Colors.white, fontSize: 14.w),
                  ),
                )
              ],
            ),
          ),
          if (widget.careModel.exercicio != null && widget.careModel.exercicio.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              decoration: BoxDecoration(
                color: RehabColors().mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15.w,
                  ),
                  Icon(
                    Icons.wysiwyg,
                    color: RehabColors().mainColor,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      widget.careModel.exercicio,
                      style: TextStyle(
                          color: RehabColors().mainColor.withOpacity(0.7), fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
            onTap: () {
              Alert(
                  context: context,
                  title: "Queremos saber o quanto voce se esforçou no exercício",
                  style: AlertStyle(
                      titleTextAlign: TextAlign.center,
                      titleStyle: TextStyle(color: Colors.black54, fontSize: 18.w),
                      buttonAreaPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w)),
                  content: StatefulBuilder(builder: (context, state) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'De 1 a 10 como quanto se esforçou: ',
                                  style: TextStyle(color: Colors.black54, fontSize: 12.w, fontWeight: FontWeight.w500),
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
                        careController.createPerEsforco(widget.careModel.id, int.tryParse(_sliderLabel));
                        Get.back();

                        Get.snackbar('Sucesso', 'Esforço avaliado!',
                            colorText: Colors.white,
                            backgroundColor: RehabColors().mainColor,
                            margin: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                            snackPosition: SnackPosition.TOP);
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
              padding: EdgeInsets.symmetric(vertical: 10.w),
              decoration: BoxDecoration(
                color: RehabColors().cautionColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15.w,
                  ),
                  Icon(
                    Icons.wysiwyg,
                    color: RehabColors().cautionColor,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      'Clique para medir seu esforço',
                      style: TextStyle(
                          color: RehabColors().cautionColor.withOpacity(0.7),
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.w),
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
