import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/wallet/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navigationbar.dart';
import 'cache.dart';

enum DevMode { local, staging, product }

class AppSingleton {
  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static AppSingleton get instance => AppSingleton.getInstance();
  static final AppSingleton _instance = AppSingleton.getInstance();
  static UserInfoModel? userInfoModel;
  static WalletModel? walletModel;

  // bottom navigation bar controller
  static PageController? controller;
  static PageController? navigatorKey;
  static CustomBottomNavigationBarState? state;
  static Queue? queue = Queue();
  static dynamic currentPage;
  static RememberMeModel? rememberMeModel;
  static SharedPreferences? _preference;
  static DevMode? devMode;

  //提供了一个工厂方法来获取该类的实例
  factory AppSingleton() => getInstance();

  static AppSingleton getInstance() {
    log("app get instance");
    init();
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  AppSingleton._internal() {
    // 初始化
  }

  static void init() async {
    log("这里初始化");
    _preference ??= await SharedPreferences.getInstance();
  }

  static Brightness? brightness;

  static Future test1() async {
    dynamic s = await Cache.getInstance().get("userinfo");
    log("reading ---->>>>>> $s");
    return Future.value(s);
  }

  static Future<UserInfoModel?> getUserInfoModel() async {
    if (userInfoModel == null) {
      UserInfoModel? model;
      try {
        String s = await Cache.getInstance().get("userinfo") as String;
        if (s.isNotEmpty) {
          Map<String, dynamic> map = json.decode(s);
          // log("string result $map");
          model = UserInfoModel.fromJson(map);
        } else {
          log("reading data is null");
        }
      } catch (err) {
        log("get user info model cache parse error ${err}");
      }

      userInfoModel = model;
      // log("get user info result $model");
      return Future.value(model);
    } else {
      return Future.value(userInfoModel);
    }
  }

  static void setUserInfoModel(UserInfoModel model) {
    userInfoModel = model;
    try {
      String userinfo = json.encode(model.toJson());
      // log("user info string value : $userinfo");
      Cache.getInstance().setString("userinfo", userinfo);
    } catch (err) {
      log("set user info model error ${err}");
    }
  }

  static void updateInfoModel(UserInfoModel model) {
    String? token;
    if (model.token == null || model.token == "") {
      token = userInfoModel?.token;
    } else {
      token = model.token;
    }
    userInfoModel = model;
    userInfoModel?.token = token;
    try {
      String userinfo = json.encode(model.toJson());
      Cache.getInstance().setString("userinfo", userinfo);
    } catch (err) {
      log("update user info model error ${err}");
    }
  }

  static void clearUserInfo() {
    userInfoModel = null;
    try {
      Cache.getInstance().remove("userinfo");
    } catch (err) {
      log("clear user info model error ${err}");
    }
  }

  static Future<RememberMeModel> getRememberMeModel() async {
    if (rememberMeModel == null) {
      rememberMeModel = RememberMeModel();
      try {
        bool s1 = Cache.getInstance().get("isRemember");
        String s2 = await Cache.getInstance().get("email") as String;
        String s3 = await Cache.getInstance().get("password") as String;
        rememberMeModel?.isRemember = s1;
        rememberMeModel?.email = s2;
        rememberMeModel?.password = s3;
      } catch (err) {
        log("get remember me model cache parse error ${err}");
      }
    }
    return Future.value(rememberMeModel);
  }

  static void setRememberMeModel(model) async {
    rememberMeModel = model;
    try {
      Cache.getInstance().setBool("isRemember", model.isRemember ?? false);
      Cache.getInstance().setString("email", model.email ?? "");
      Cache.getInstance().setString("password", model.password ?? "");
    } catch (err) {
      log("set remember me model cache parse error ${err}");
    }
  }

  static void deleteRememberMeModel() async {
    rememberMeModel = null;
    try {
      Cache.getInstance().remove("isRemember");
      Cache.getInstance().remove("email");
      Cache.getInstance().remove("password");
    } catch (err) {
      log("set remember me model cache parse error ${err}");
    }
  }
}

class RememberMeModel {
  bool? isRemember;
  String? email;
  String? password;

  @override
  String toString() {
    return 'RememberMeModel{isRemember: $isRemember, email: $email, password: $password}';
  }
}
