import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class Cache {
  SharedPreferences? prefs;

  Cache._() {
    log("_ init");
    init();
  }

  static Cache? _instance;

  Cache._pre(SharedPreferences prefs) {
    log("_pre ");
    this.prefs = prefs;
  }

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<Cache> preInit() async {
    log("pre init");
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = Cache._pre(prefs);
    }
    return _instance!;
  }

  static Cache getInstance() {
     _instance ??= Cache._();
    return _instance!;
  }

  void init() async {
    log("init");
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String _value) {
    prefs?.setString(key, _value).then((value) => log("save string value is ${value?'success':'fail'}  key is $key value is "));
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}
