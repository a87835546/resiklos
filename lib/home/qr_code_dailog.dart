import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/utils/app_singleton.dart';

class QRCodeDialog extends Dialog {
  const QRCodeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("rp address ----->>>>${AppSingleton.userInfoModel?.rpWalletAddress}");
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
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Text("rp:${AppSingleton.userInfoModel?.rpWalletAddress}"),
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
      data: AppSingleton.userInfoModel?.rpWalletAddress??"",
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
