import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

///错误提示样式的toast
void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

void showWarnToast1(String text) {
  Fluttertoast.showToast(
      msg: text,
      // toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.lightGreenAccent,
      textColor: Colors.black);
}


var time = const Duration(seconds: 1);
///普通提示样式的toast
void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

void showLoading() {
  EasyLoading.show(
    status: "loading...",
    maskType: EasyLoadingMaskType.black,
  );
}

void showSuccessLoading({String? title}) {
  EasyLoading.showSuccess(
    title??"success...",
    duration: time,
    maskType: EasyLoadingMaskType.black,
  );
}
void showText(String text) {
  EasyLoading.showInfo(
    text,
    duration: time,
    maskType: EasyLoadingMaskType.black,
  );
}

void showErrorText(String text) {
  EasyLoading.showError(
    text,
    duration: time,
    maskType: EasyLoadingMaskType.black,
  );
}
