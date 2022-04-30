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
    HttpManager.baseUrl = "https://resiklos-merchant.trifectacore.tech/";
    var res =
        await HttpManager.get(url: "api/public/merchants/?no_pagination=1")
            as List;
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
    HttpManager.baseUrl = "https://resiklos-merchant.trifectacore.tech/";
    String url = id == 0
        ? "api/public/vouchers?no_pagination=1"
        : "api/public/vouchers?merchant=$id&no_pagination=1";
    var res = await HttpManager.get(url: url) as List;
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
    HttpManager.baseUrl = "https://resiklos-merchant.trifectacore.tech/";
    String url = isCode
        ? "api/public/vouchers/1/claim_by_id/"
        : "api/public/vouchers/1/claim_by_code/";
    Map<String, dynamic> map = new HashMap();
    map.putIfAbsent("email", () => AppSingleton.userInfoModel?.email);
    map.putIfAbsent("access_token", () => AppSingleton.userInfoModel?.token);
    map.putIfAbsent("code", () => code);
    var res = await HttpManager.post(url: url, params: map);
    log("claim res ---->>>>${jsonEncode(res)}");
    try {
      showToast(res["details"]);
      return Future.value(res["details"] == "Success");
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(null);
  }
}
