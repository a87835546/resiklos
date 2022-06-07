import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/scan/scan_request.dart';
import 'package:resiklos/scan/verify_amout_list.dart';
import 'package:resiklos/scan/verify_confirm_page.dart';
import 'package:resiklos/scan/verify_weight_view.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/utils/navigator_util.dart';

class VerifyProceedPage extends BaseStatefulWidget {
  final String address;

  const VerifyProceedPage({Key? key, required this.address}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _VerifyProceedPageState();
}

class _VerifyProceedPageState extends BaseStatefulState<VerifyProceedPage> {
  num _price = 0;
  num _weight = 0;

  @override
  void initState() {
    super.initState();
    getPrice();
    setState(() {
      _price = 1.22;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: GestureDetector(
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
                    // height: 460,
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
                                          "VERIFY",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Text(
                                        "Verify Proceeding given plastic waste to convert into a value,This transaction is not reversible. Enter amount to proceed.",
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
                                ),
                              ),
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
                          padding: EdgeInsets.only(top: 10, bottom: 0),
                          child: VerifyWeightView(
                            input: (v) {
                              setState(() {
                                _weight = num.parse(v);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 15),
                          child: VerifyAmountList(
                            weight: _weight,
                            price: _price,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30, bottom: 0),
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
                              "PROCEED",
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
                          )
                        ],
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        log("send rsg");
                        NavigatorUtil.push(
                            context,
                            VerifyPage(
                              weight: _weight,
                              price: _price,
                              address: widget.address,
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).viewInsets.bottom > 0 ? 80 : 0,
                  )
                ],
              ),
            ),
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            behavior: HitTestBehavior.opaque,
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, "1");
          return true;
        });
  }

  void getPrice() async {
    var r = await getPlasticPrice();
    setState(() {
      log("price --->>> $r");
      _price = num.parse(r);
    });
  }

}
