import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import "package:http/http.dart" as http;
import 'dart:convert' show json;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/sign_up_in/sign_in.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignRequest {
  static final plugin = FacebookLogin(debug: true);

  /**
   * uesing email and password to login
   */
  static Future<UserInfoModel?> login(String email, String password) async {
    var params = {
      "email": email,
      "password": password,
      'loginDevice': 1, // 1 login by mobile
    };
    var result = await HttpManager.post(url: "user/login", params: params);
    log("login result $result");
    UserInfoModel? model;
    try {
      if (result["data"] != null && result["code"] == 200) {
        model = UserInfoModel.jsonToObject(result["data"]);
        AppSingleton.setUserInfoModel(model);
      } else {
        showWarnToast(result["message"] ?? "Sign In Fail");
      }
    } catch (err) {
      log("parser user info model fail ${err.toString()}");
    }
    return Future.value(model);
  }

  /**
   * use name to register
   */
  static Future<UserInfoModel?> registerByName(
      name, email, password, inviteCode) async {
    var params = {
      "deviceType": Platform.isIOS ? 0 : 1,
      "inviteCode": inviteCode,
      "loginType": 2,
      "email": email,
      "password": password,
      "userName": name,
    };
    var result = await HttpManager.post(url: "user/register", params: params);
    log("login result $result");
    UserInfoModel? model;
    try {
      if (result["data"] != null && result["code"] == 200) {
        model = UserInfoModel.jsonToObject(result["data"]);
        AppSingleton.setUserInfoModel(model);
      } else {
        EasyLoading.showError(result["message"] ?? "Register User Error");
      }
    } catch (err) {
      log("parser user info model fail ${err.toString()}");
    } finally {
      EasyLoading.dismiss();
    }
    return Future.value(model);
  }

  static Future<bool> getOtp(email) async {
    var result =
        await HttpManager.get(url: "user/sendPasswordOtp?email=${email}");
    log("get reset password otp result $result");
    try {
      if (result["code"] == 200) {
        showSuccessLoading(title: "Send OTP Success");
        return Future.value(true);
      } else {
        EasyLoading.showError(result["message"] ?? "Get Otp Error");
        return Future.value(false);
      }
    } catch (err) {
      log("parser reset password ot fail ${err.toString()}");
    } finally {
      EasyLoading.dismiss();
    }
    return Future.value(false);
  }

  static Future resetPassword(email, otp, password) async {
    var result = await HttpManager.post(
        url: "user/resetPasswd?email=${email}&otp=$otp&newPassword=$password",
        params: {});
    log("get reset password otp result $result");
    try {
      if (result["code"] == 200) {
        EasyLoading.showSuccess("Reset Password Successful");
        return Future.value(true);
      } else {
        EasyLoading.showError(result["message"] ?? "Reset Password Error");
        return Future.value(false);
      }
    } catch (err) {
      log("parser reset password ot fail ${err.toString()}");
      return Future.value(false);
    } finally {
      EasyLoading.dismiss();
    }
  }

  // google disconnect
  static Future<void> handleSignOut() => _googleSignIn.disconnect();

  // google login
  static Future<void> handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      // showWarnToast("People API gave a ${response.statusCode} "
      //     "response. Check logs for details.");
      log('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);
    var _contactText;
    if (namedContact != null) {
      _contactText = "I see you know $namedContact!";
    } else {
      _contactText = "No contacts to display.";
    }
  }

  static Future<bool> handleSignIn() async {
    bool success = false;

    try {
      GoogleSignInAccount? res = await _googleSignIn.signIn();
      log("google login success ${res}");
      if (res?.displayName != null && res?.id != null && res?.email != null) {
        success = await loginBySocialMedia(
            res?.id, res?.displayName, res?.email, 1, res?.photoUrl);
        handleGetContact(res!);
      }
    } catch (error) {
      log("google login error : ${error}");
    }
    return Future.value(success);
  }

  static String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  /// facebook login

  static Future<bool> onPressedLogInButton() async {
    var loginResult = await plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    if (loginResult.status == FacebookLoginStatus.cancel) {
      return Future.value(false);
    } else {
      return await updateLoginInfo();
    }
  }

  static Future<void> onPressedExpressLogInButton(BuildContext context) async {
    final res = await plugin.expressLogin();
    if (res.status == FacebookLoginStatus.success) {
      await updateLoginInfo();
    } else {
      await showDialog<Object>(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Can't make express log in. Try regular log in."),
        ),
      );
    }
  }

  static Future<void> onPressedLogOutButton() async {
    await plugin.logOut();
    await updateLoginInfo();
  }

  static Future<void> getSdkVersion() async {
    final sdkVesion = await plugin.sdkVersion;
    log("facebook sdk version $sdkVesion");
  }

  static Future<bool> updateLoginInfo() async {
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
      if (profile?.userId != null && profile?.name != null) {
        return await loginBySocialMedia(
            profile?.userId, profile?.name, email, 0, imageUrl);
      } else {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  /**
   * login by social
   */
  static Future<bool> loginBySocialMedia(
      userId, username, _email, _loginType, _imageUrl) async {
    var params = {
      "deviceType": Platform.isIOS ? 0 : 1,
      "email": _email,
      "inviteCode": "",
      "loginType": _loginType, // fb 0 google 1
      "userId": userId,
      "userName": username,
      "avatar": _imageUrl
    };
    log("request params $params");
    var result =
        await HttpManager.post(url: "user/registerBySocial", params: params);
    try {
      var temp = result["data"];
      UserInfoModel object = UserInfoModel.jsonToObject(temp);
      AppSingleton.setUserInfoModel(object);
      log("user model $object");
      if (null != object) {
        return Future.value(true);
      } else {
        showWarnToast("Login Error");
        return Future.value(false);
      }
    } catch (err) {
      showErrorText('Parser User Info Error ${err}');
      return Future.value(false);
    }
  }

  static void logout(context) async {
    Map<String, dynamic> map = {};
    // var res = await HttpManager.post(url: "user/logout", params: map);
    // log("logout ---->>>> $res");

    try {
      AppSingleton.clearUserInfo();
      NavigatorUtil.push(context, SignInPage());
      handleSignOut();
      onPressedLogOutButton();
    } catch (err) {
      log("parser user info error ${err}");
    }
  }
}
