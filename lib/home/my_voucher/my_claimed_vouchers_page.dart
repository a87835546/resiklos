import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/home/my_voucher/claimed_voucher_model.dart';
import 'package:resiklos/home/transactions/transaction_detail_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/shop/marketplace_request.dart';
import 'package:resiklos/shop/shop_voucher_item.dart';
import 'package:resiklos/shop/voucher_model.dart';
import 'package:resiklos/utils/constants.dart';

class MyClaimedVouchersPage extends StatefulWidget {
  const MyClaimedVouchersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyVoucherPageState();
}

class _MyVoucherPageState extends State<MyClaimedVouchersPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  List<ClaimedVoucherModel> _lists = [];
  int _pageNum = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var list = await MarketPlaceRequest.claimedVoucher(false);
    log("merchant list --->>$list");
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
    setState(() {
      _lists = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      physics: const BouncingScrollPhysics(),
      enablePullUp: true,
      enablePullDown: true,
      header: const WaterDropHeader(),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
      ),
      child: _lists.length == 0
          ? Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text("No data"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                ClaimedVoucherModel model = _lists[index];
                return ShopVoucherItem(
                  model: model.voucher!,
                  isClaimed: true,
                );
              },
              itemCount: _lists.length,
              shrinkWrap: true,
            ),
      onRefresh: () {
        log("refresh");
        _pageNum = 1;
        _refreshController.resetNoData();
        getData();
      },
      onLoading: () {
        log('loading more');
        _pageNum++;
        getData();
      },
    );
  }
}
