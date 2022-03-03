import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog extends Dialog {
  List<String> data = [
    "补材料申请",
    "面签申请",
    "暂停申请",
    "提醒",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
            width: 220.0,
            height: 200.0,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: _createQrCode(),
            )),
      ),
    );
  }

  _createQrCode() {
    return QrImage(
      data: "1234567890",
      version: QrVersions.auto,
      size: 200.0,
    );
  }
}

void showCustomDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return QRCodeDialog();
      });
}
