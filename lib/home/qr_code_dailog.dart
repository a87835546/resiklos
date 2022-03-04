import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog extends Dialog {
  const QRCodeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: Text("this my wallet address"),
                  ),
                  _createQrCode()
                ],
              ),
            )),
      ),
    );
  }

  _createQrCode() {
    return QrImage(
      data: "12345678901111111111111111111",
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
