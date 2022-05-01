import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:resiklos/shop/merchant_model.dart';
import 'package:resiklos/shop/voucher_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';

class MarketPlaceRequest {
  // /api/public/vouchers?merchant=1&no_pagination=1
  static Future<List<MerchantModel>> getList() async {
    var res = await HttpManager.get(
        url: "api/public/merchants/?no_pagination=1", isMerchant: true) as List;
    // log("merchant list ---->>>>${jsonEncode(res)}");
    List<MerchantModel> _temp = [];
    try {
      for (var element in res) {
        _temp.add(MerchantModel.fromJson(element));
      }
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(_temp);
  }

  static Future<List<VoucherModel>> getVoucherList(int id) async {
    String url = id == 0
        ? "api/public/vouchers?no_pagination=1"
        : "api/public/vouchers?merchant=$id&no_pagination=1";
    var res = await HttpManager.get(url: url, isMerchant: true) as List;
    // log("voucher list ---->>>>${jsonEncode(res)}");
    List<VoucherModel> _temp = [];
    try {
      for (var element in res) {
        _temp.add(VoucherModel.fromJson(element));
      }
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(_temp);
  }

  static Future claimVoucher(bool isCode, String code) async {
    String url = isCode
        ? "api/public/vouchers/1/claim_by_id/"
        : "api/public/vouchers/claim_by_code";
    Map<String, dynamic> map = HashMap();
    map.putIfAbsent("email", () => AppSingleton.userInfoModel?.email);
    map.putIfAbsent("code", () => code);
    var res = await HttpManager.post(url: url, params: map, isMerchant: true);
    log("claim res ---->>>>${jsonEncode(res)}");
    try {
      if (res["response"]["data"]["code"] == 200) {
        return Future.value(true);
      } else {
        showToast("${res["details"]} ${res["response"]["data"]["message"]}");
        return Future.value(false);
      }
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(null);
  }

  static Future claimedVoucher() async {
    String url = "api/public/claimed_vouchers";
    var res = await HttpManager.get(url: url, isMerchant: true);
    log("claimed vouchers res ---->>>>${jsonEncode(res)}");
    try {
      if (res["response"]["data"]["code"] == 200) {
        return Future.value(true);
      } else {
        showToast("${res["details"]} ${res["response"]["data"]["message"]}");
      }
      return Future.value(res["details"] == "Success");
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(null);
  }
}
