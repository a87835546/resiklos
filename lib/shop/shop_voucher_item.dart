import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class ShopVoucherItem extends StatefulWidget {
  const ShopVoucherItem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopVoucherItemState();
}

class _ShopVoucherItemState extends State<ShopVoucherItem> {
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
                    child: const Icon(
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
                            "50% off",
                            style: const TextStyle(
                                color: Color(0xff707070),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            "Min. spend 100",
                            style: const TextStyle(
                                color: Color(0xffD4D4D4),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Text(
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
                GestureDetector(
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
                  onTap: () {
                    log("点击获取优惠券");
                  },
                ),
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
