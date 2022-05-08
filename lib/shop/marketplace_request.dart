import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:resiklos/home/my_voucher/claimed_voucher_model.dart';
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
      if (res["response"]["code"] == 200) {
        return Future.value(true);
      } else {
        showToast("${res["details"]} ${res["response"]["message"]}");
        return Future.value(false);
      }
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    }
    return Future.value(null);
  }

  static Future claimedVoucher(bool isUsed) async {
    String url =
        "api/public/claimed_vouchers?is_used=${isUsed == false ? 0 : 1}";
    var res = await HttpManager.get(url: url, isMerchant: true);
    log("claimed vouchers res ---->>>>${jsonEncode(res)}");
    try {
      List<ClaimedVoucherModel> _list = [];
      if (res["count"] > 0) {
        List temp = res["results"];
        temp.forEach((element) {
          _list.add(ClaimedVoucherModel.fromJson(element));
        });
        return Future.value(_list);
      } else {
        showToast("${res["details"]} ${res["response"]["message"]}");
        return Future.value([]);
      }
    } catch (e) {
      log("parser merchant list error --->>>${e.toString()}");
    } finally {}
    return Future.value(null);
  }
}
