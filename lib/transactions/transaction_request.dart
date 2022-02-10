import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resiklos/transactions/transaction_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';

class TransactionRequest {
  /**
   * query user transaction request
   */
  static Future<List<TransactionModel>> queryTransaction(type,current) async {
    var result = await HttpManager.get(
        url: "/transaction/queryTransaction?type=$type&id=${AppSingleton.userInfoModel?.id.toString()}&pageSize=10&currentNum=$current");
    log("login result $result");
    List<TransactionModel> list = [];
    try {
      if (result["data"] != null &&
          result["code"] == 200 &&
          result["data"]["records"] != null) {
        List temp = result["data"]["records"];
        temp.forEach((element) {
          list.add(TransactionModel.fromJson(element));
        });
      } else {
        EasyLoading.showError(result["message"] ?? "query transaction error");
      }
    } catch (err) {
      log("query user transaction model fail ${err.toString()}");
    } finally {}
    return Future.value(list);
  }
  static Future<List<TransactionModel>> queryReferral(current) async {
    var result = await HttpManager.get(
        url: "/transaction/queryReferral?id=${AppSingleton.userInfoModel?.id.toString()}&pageSize=10&currentNum=$current");
    log("login result $result");
    List<TransactionModel> list = [];
    try {
      if (result["data"] != null &&
          result["code"] == 200 &&
          result["data"]["records"] != null) {
        List temp = result["data"]["records"];
        temp.forEach((element) {
          list.add(TransactionModel.fromJson(element));
        });
      } else {
        EasyLoading.showError(result["message"] ?? "query transaction error");
      }
    } catch (err) {
      log("query user transaction model fail ${err.toString()}");
    } finally {}
    return Future.value(list);
  }
}
