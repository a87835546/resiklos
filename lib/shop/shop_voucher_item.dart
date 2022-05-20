import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/home_verify_emal_page.dart';
import 'package:resiklos/home/kyc/kyc_finished_page.dart';
import 'package:resiklos/home/kyc/kyc_frist_page.dart';
import 'package:resiklos/shop/marketplace_request.dart';
import 'package:resiklos/shop/merchant_view_dailogs.dart';
import 'package:resiklos/shop/voucher_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/toast.dart';

class ShopVoucherItem extends StatefulWidget {
  final VoucherModel model;
  final bool? isClaimed;

  const ShopVoucherItem({Key? key, required this.model, this.isClaimed = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopVoucherItemState();
}

class _ShopVoucherItemState extends State<ShopVoucherItem> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0)],

              // boxShadow: [BoxShadow(spreadRadius: 5, color: Colors.redAccent)],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    child: widget.model.imageUrl != null
                        ? Image.network(widget.model.imageUrl ?? "")
                        : const Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.grey,
                          ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            "${widget.model.amount}",
                            style: const TextStyle(
                                color: Color(0xff707070),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            widget.model.name ?? "50% off",
                            style: const TextStyle(
                                color: Color(0xffD4D4D4),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            widget.model.voucherSubCategoryName ??
                                "99% Claimed",
                            style: const TextStyle(
                                color: Color(0xff00A6BE),
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 25,
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        "CLAIM",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      log("点击获取优惠券 email state --->>>${AppSingleton.userInfoModel!.emailVerificationStatus} kyc state-->>>${AppSingleton.userInfoModel!.kycVerificationStatus}");
                      if (AppSingleton.userInfoModel!.emailVerificationStatus ==
                              1 &&
                          AppSingleton.userInfoModel!.kycVerificationStatus ==
                              2) {
                        var res = await MarketPlaceRequest.claimVoucher(
                            false, widget.model.code.toString());
                        if (res) {
                          showText("Claimed Success");
                        } else {
                          showText("Claimed fail");
                        }
                      } else if (AppSingleton
                                  .userInfoModel!.emailVerificationStatus ==
                              1 &&
                          AppSingleton.userInfoModel!.kycVerificationStatus ==
                              1) {
                        log("We are currently processing your KYC Verification Details. Please come back again or contact our support team.");
                        showText("We are currently processing your KYC Verification Details. Please come back again or contact our support team.");
                        return;
                      } else {
                        ViewDialogs.clickVoucherView(context, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            if (AppSingleton
                                    .userInfoModel!.emailVerificationStatus !=
                                1) {
                              return HomeVerifyEmail();
                            }

                            if (AppSingleton
                                    .userInfoModel!.verificationStatus >=
                                1) {
                              return KycFirstPage();
                            }

                            if (AppSingleton
                                        .userInfoModel!.verificationStatus >=
                                    2 &&
                                AppSingleton
                                        .userInfoModel!.kycVerificationStatus >
                                    0) {
                              return KYCFinishedPage();
                            }
                            return KYCFinishedPage();
                          }));
                        });
                      }
                    },
                  ),
                  visible: widget.isClaimed == false,
                ),
                Visibility(
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        "SHOW CODE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        _showCode = true;
                      });
                    },
                  ),
                  visible: widget.isClaimed == true && _showCode == false,
                ),
                Visibility(
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        widget.model.code ?? "",
                        style: TextStyle(color: mainColor()),
                      ),
                    ),
                    onTap: () {
                      copyToast(widget.model.code ?? "", context);
                    },
                  ),
                  visible: _showCode,
                )
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
