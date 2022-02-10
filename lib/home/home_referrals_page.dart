import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/transactions/transaction_model.dart';
import 'package:resiklos/transactions/transaction_request.dart';
import 'package:resiklos/utils/app_singleton.dart';

import '../rk_app_bar.dart';
import 'home_referrals_share_widget.dart';
import 'home_referrals_transaction_item.dart';

class HomeReferrals extends BaseStatefulWidget {
  const HomeReferrals({Key? key}) : super(key: key);


  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _HomeReferralsState();

}

class _HomeReferralsState extends BaseStatefulState<HomeReferrals> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    log("user info ---->>>>>>>${AppSingleton.userInfoModel}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: "REFERRALS",
      ),
      backgroundColor: Color(0xffFAFAFA),
      body: Container(
          child: ListView(
        children: [
          HomeReferralsShareWidget(),
          FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError || snapshot.data == null) {
                return Container(
                  child: null,
                );
              } else {
                List temp = snapshot.data[0] as List<TransactionModel>;
                return Container(
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: temp.map((e) {
                      return HomeReferralsTransactionItem(e);
                    }).toList(),
                  ),
                );
              }
            },
            future: fetchData(),
          )
        ],
      )),
    );
  }
  Future fetchData() async{
    return Future.wait([getData()]);
  }
  
  Future<List<TransactionModel>> getData() async {
    var result = await TransactionRequest.queryReferral(1);
    return result;
  }
}
