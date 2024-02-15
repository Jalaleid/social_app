// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, constant_identifier_names, depend_on_referenced_packages, duplicate_ignore
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

// void SignOut(context) {
//   CacheHelper.removeData(key: 'token').then((value) {
//     if (value) {
//       NavigateAndFinish(context, ShopLoginScreen());
//     }
//   });
// }

void showToast({
  required String text,
  required ToastStats state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStats { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStats state) {
  Color res;

  switch (state) {
    case ToastStats.SUCCESS:
      res = Colors.green;
      break;
    case ToastStats.ERROR:
      res = Colors.red;
      break;
    case ToastStats.WARNING:
      res = Colors.amber;
      break;
  }
  return res;
}
