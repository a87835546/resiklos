import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resiklos/home/kyc/kyc_model.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';

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

/// type == 0 id 1 driver License 2 passport 3 other
Future uploadIDImage(String url, String backUrl, int type) async {
  var result = await HttpManager.post(url: "/kyc/uploadId", params: {
    "id": AppSingleton.userInfoModel?.id,
    "url": url,
    "backUrl": backUrl,
    "idType": type
  });
  log("upload image result ---->>>> $result");
  try {
    return Future.value(200 == result["code"]);
  } catch (e) {
    log("upload image error ---->>>>$e");
    return Future.value(false);
  }
}

Future uploadFacialImage(url) async {
  var result = await HttpManager.post(url: "/kyc/uploadSelfie", params: {
    "id": AppSingleton.userInfoModel?.id,
    "url": url,
    "backUrl": "",
    "idType": ""
  });
  log("upload image result ---->>>> $result");
  try {
    return Future.value(200 == result["code"]);
  } catch (e) {
    log("upload image error ---->>>>$e");
    return Future.value(false);
  }
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

Future fetchKycByUserId() async {
  var result = await HttpManager.get(
      url: "kyc/queryKyc?userId=${AppSingleton.userInfoModel?.id}");
  log("get kyc result ---->>>> $result");
  try {
    KycModel model = KycModel.fromJson(result["data"]);
    return Future.value(model);
  } catch (err) {
    log("parser get kyc fail ${err.toString()}");
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

Future getEmailOtp() async {
  var result = await HttpManager.get(
      url: "/user/sendVerifyEmail?email=${AppSingleton.userInfoModel?.email}");
  log("get email otp result ---->>>> $result");
  if (null != result["code"] && result["code"] == 200) {
    showSuccessLoading(title: "Send OTP success");
    return Future.value(true);
  } else {
    showErrorText(result["message"] ?? "get email otp fail");
    return Future.value(false);
  }
}

Future verifyEmail(otp) async {
  var result = await HttpManager.get(
      url:
          "user/verifyEmail?email=${AppSingleton.userInfoModel?.email}&otp=$otp");
  log("verify email result ---->>>> $result");
  if (null != result["code"] && result["code"] == 200) {
    return Future.value(true);
  } else {
    showErrorText(result["message"] ?? "get email otp fail");
    return Future.value(false);
  }
}

Future insertNotification() async {
  var result = await HttpManager.post(
      url:
      "notification/addNews",params: {"content":"test1111","desc":"asdfkljsfklsdf","type":"3"});
  log("verify email result ---->>>> $result");
  if (null != result["code"] && result["code"] == 200) {
    return Future.value(true);
  } else {
    showErrorText(result["message"] ?? "get email otp fail");
    return Future.value(false);
  }
}


Future uploadUserInfo(
    birthday, country, firstname, gender, lastname, mobile) async {
  Map<String, dynamic> params = {
    "birthday": birthday,
    "country": country,
    "firstname": firstname,
    "gender": gender == true ? 1 : 0,
    "id": AppSingleton.userInfoModel?.id,
    "lastname": lastname,
    "mobile": mobile
  };
  var result =
      await HttpManager.post(url: "kyc/modifyUserInfo", params: params);
  log("upload user info result ---->>>> $result");
  if (null != result["code"] && result["code"] == 200) {
    showSuccessLoading();
    return Future.value(true);
  } else {
    showErrorText(result["message"] ?? "upload user info fail");
    return Future.value(false);
  }
}
