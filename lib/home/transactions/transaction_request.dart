import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';

class TransactionRequest {
  /**
   * query user transaction request
   */
  static Future<List<TransactionModel>> queryTransaction(type, current) async {
    current = current - 1;
    // type = type + 1;
    String? url = type == 0
        ? AppSingleton.userInfoModel?.email
        : AppSingleton.userInfoModel?.rpWalletAddress.toString();
    var result = await HttpManager.get(
        url:
            "transaction/queryTransactionV2?type=$type&email=$url&pageSize=10&currentNum=$current");
    log("transaction result $result");
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
        url:
            "/user/queryReferrals?inviteCode=${AppSingleton.userInfoModel?.inviteCode.toString()}&pageSize=10&currentNum=$current");
    log("query referral res $result");
    List<TransactionModel> list = [];
    try {
      if (result["data"] != null && result["code"] == 200) {
        List temp = result["data"];
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
