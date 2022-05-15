import 'dart:convert';
import 'dart:developer';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/wallet/wallet_model.dart';

Future createWallet(String password) async {
  var res = await HttpManager.post(url: "wallet/create", params: {
    "password": password,
    "userEmail": AppSingleton.userInfoModel?.email
  });
  log("create new wallet res ---->>>>>${jsonEncode(res)}");
  try {
    if (res["code"] == 200) {
      WalletModel model = WalletModel.fromJson(res["data"]);
      return Future.value(model);
    }
  } catch (e) {
    log("create wallet parser error --->>> $e");
  }
  return Future.value(null);
}

Future importWalletFromSeedPhrase(String seed) async {
  var res = await HttpManager.post(url: "wallet/importWallet", params: {
    "seedPhrase": seed,
    "userEmail": AppSingleton.userInfoModel?.email
  });
  log("create new wallet res ---->>>>>$res");
  try {} catch (e) {
    log("create wallet parser error --->>> $e");
  }
  return Future.value(null);
}

Future<List> fetchAllWallet() async {
  var res = await HttpManager.get(
      url: "wallet/fetchAllWallet?email=${AppSingleton.userInfoModel?.email}");
  log("fetch all wallet  res ---->>>>>$res");
  try {
    List<WalletModel> _list = [];
    List temp = res["data"];
    for (var value in temp) {
      _list.add(WalletModel.fromJson(value));
    }
    return Future.value(_list);
  } catch (e) {
    log("fetch all wallet error --->>> $e");
  }
  return Future.value([]);
}

Future fetchWallet() async {
  var res = await HttpManager.get(
      url: "wallet/balance?email=${AppSingleton.userInfoModel?.email}");
  log("fetch all wallet  res ---->>>>>$res");
  try {
    return Future.value(res["data"]);
  } catch (e) {
    log("fetch all wallet error --->>> $e");
  }
  return Future.value([]);
}

Future complete(String address) async {
  var res = await HttpManager.get(
      url:
          "wallet/complete?email=${AppSingleton.userInfoModel?.email}&address=$address");
  log("complete  wallet  res ---->>>>>$res");
  try {
    return Future.value(res["code"] == 200);
  } catch (e) {
    log("complete  wallet error --->>> $e");
  }
  return Future.value([]);
}

Future completeTransferRSG(String txId, String amount, String toAddress,
    {String? note}) async {
  Map<String, dynamic> params = {
    "amount": amount,
    "email": AppSingleton.userInfoModel?.email,
    "note": note,
    "toAddress": toAddress,
    "txId": txId
  };
  var res =
      await HttpManager.post(url: "wallet/completeTransferRSG", params: params);
  log("complete  wallet  res ---->>>>>$res");
  try {
    return Future.value(res["code"] == 200);
  } catch (e) {
    log("complete  wallet error --->>> $e");
  }
  return Future.value([]);
}
