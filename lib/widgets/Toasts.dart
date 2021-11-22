import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void avisarToast({required BuildContext buildContext, required String texto, required IconData iconData,required Color color}){
  FToast fToast =FToast().init(buildContext);
  fToast.showToast(child: funToast(texto: texto, iconData: iconData, color: color));
}

Widget funToast({required String texto, required IconData iconData,required Color color}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: color,
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(iconData),
      SizedBox(
        width: 12.0,
      ),
      Text(texto),
    ],
  ),
);