import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/constants.dart';

class HomeReferralsTransactionItem extends StatefulWidget {
  final UserInfoModel model;

  const HomeReferralsTransactionItem(this.model, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeReferralsTransactionItem();
}

class _HomeReferralsTransactionItem
    extends State<HomeReferralsTransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Color(0xfffafafa), width: 2, style: BorderStyle.solid)),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text("${widget.model.email ?? widget.model.nickName}"),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: Text(
                    "${widget.model.createTime}",
                    style:
                        const TextStyle(color: Color(0xffD4D4D4), fontSize: 12),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
