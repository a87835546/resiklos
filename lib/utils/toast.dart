import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resiklos/wallet/show_toast.dart' as wallet;

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

void copyToast(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    wallet.showToast(context, "copied " + text);
  });
}

void showLoading({String? title}) {
  EasyLoading.show(
    status: title ?? "loading...",
    maskType: EasyLoadingMaskType.black,
  );
}

void showSuccessLoading({String? title}) {
  EasyLoading.showSuccess(
    title ?? "success...",
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
