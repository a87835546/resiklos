import 'dart:developer';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';

Future createWallet(String password) async {
  var res = await HttpManager.post(
      url: "wallet/create",
      params: {"password": password,
        "id": AppSingleton.userInfoModel?.email});
  log("create new wallet res ---->>>>>$res");
  try {

  } catch (e) {}
  return Future.value(null);
}
