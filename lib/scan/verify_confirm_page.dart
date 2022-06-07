import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/scan/transfer_amout_list.dart';
import 'package:resiklos/scan/transfer_wallet_view.dart';
import 'package:resiklos/scan/verify_amount_view.dart';
import 'package:resiklos/scan/verify_amout_list.dart';
import 'package:resiklos/scan/verify_successfully_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/utils/event_bus_util.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';

class VerifyPage extends BaseStatefulWidget {
  final num weight;
  final num price;
  final String address;

  const VerifyPage(
      {Key? key,
      required this.weight,
      required this.price,
      required this.address})
      : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _VerifyPageState();
}

class _VerifyPageState extends BaseStatefulState<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.grey,
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      child: const Text(
                                        "CONFIRMATION",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Text(
                                      "Verifying given plastic waste to convert into a value,This transaction is not reversible. Enter amount to proceed.",
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0x7676801F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: 30,
                                height: 30,
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context, "1");
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(60),
                            child: Container(
                                width: 120,
                                height: 120,
                                color: const Color(0xffeeeeee),
                                child: QrImage(
                                  data: "${widget.address}",
                                  version: 4,
                                  gapless: false,
                                  eyeStyle: const QrEyeStyle(
                                      eyeShape: QrEyeShape.square,
                                      color: ResiklosColors.primary),
                                  dataModuleStyle: const QrDataModuleStyle(
                                      dataModuleShape: QrDataModuleShape.circle,
                                      color: ResiklosColors.primaryDark),
                                  embeddedImage:
                                      const AssetImage('imgs/logo@2x.png'),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: const Size(25, 25),
                                  ),
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        "Uh oh! Something went wrong...",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                )),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "QR CODE",
                          style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "${widget.address}",
                          style: TextStyle(
                              color: mainColor(),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: VerifyConfirmAmountView(
                          weight: widget.weight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: VerifyAmountList(
                          weight: widget.weight,
                          price: widget.price,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  height: 80,
                  color: mainColor(),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: double.maxFinite,
                          alignment: Alignment.center,
                          child: const Text(
                            "CONFIRM",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          height: double.maxFinite,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async{
                      log("send rsg");
                      transferRP();

                    },
                    behavior: HitTestBehavior.opaque,
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, "1");
          return true;
        });
  }

  void transferRP() async {
    num amount = widget.price;
    log("message--->>>${amount}");
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    // if (amount > num.parse(_balance)) {
    //   showErrorText(
    //       "Please input valid amount,your available balance is $_balance");
    //   return;
    // }

    Map<String, dynamic> temp = {
      "email": AppSingleton.userInfoModel?.email,
      "amount": widget.price * widget.weight,
      "address": widget.address,
      "name": AppSingleton.userInfoModel?.nickName,
    };
    var res = await HttpManager.post(url: "wallet/sellerPlastic", params: temp);
    log("transfer --->>>$res");
    if (res["code"] == 200) {
      showText("Transfer RP Success");
      // EventBusUtil.fire(RefreshRpEvent());
      // Navigator.of(context).pop();
      TransactionModel model = TransactionModel.fromJson(res["data"]);
      NavigatorUtil.push(
          context,
          VerifySuccessfullyPage(
            weight: widget.weight,
            amount: widget.price,
            address: widget.address,
            data: model,
          ));
    } else {
      showText("Transfer RP Fail ${res["message"]}");
    }
  }
}
