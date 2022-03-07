import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';

Future deleteAccount() async {
  var result = await HttpManager.get(
      url: "user/deleteAccount?id=${AppSingleton.userInfoModel?.id}");
  log("delete account result $result");
  try {
    if (result["code"] == 200) {
      EasyLoading.showSuccess("Delete Account Successful");
      return Future.value(true);
    } else {
      EasyLoading.showError(result["message"] ?? "Delete Account Error");
      return Future.value(false);
    }
  } catch (err) {
    log("parser delete account fail ${err.toString()}");
    return Future.value(false);
  } finally {
    EasyLoading.dismiss();
  }
}

Future uploadImage(url) async {
  var result = await HttpManager.post(
      url: "/user/uploadAvatar",
      params: {"id": AppSingleton.userInfoModel?.id, "url": url});
  log("upload image result ---->>>> $result");
}

Future getUserProfile() async {
  var result = await HttpManager.get(
      url: "user/profile?id=${AppSingleton.userInfoModel?.id}");
  log("get user's profile result ---->>>> $result");
  try {
    UserInfoModel userInfoModel = UserInfoModel.jsonToObject(result["data"]);
    return Future.value(userInfoModel);
  } catch (err) {
    log("parser delete account fail ${err.toString()}");
    return Future.value(false);
  } finally {
    EasyLoading.dismiss();
  }
}

Future createRpWalletAddress() async {
  var result = await HttpManager.get(
      url: "user/profile?id=${AppSingleton.userInfoModel?.id}");
  log("get user's profile result ---->>>> $result");
  try {
    UserInfoModel userInfoModel = UserInfoModel.jsonToObject(result["data"]);
    return Future.value(userInfoModel);
  } catch (err) {
    log("parser delete account fail ${err.toString()}");
    return Future.value(false);
  } finally {
    EasyLoading.dismiss();
  }
}