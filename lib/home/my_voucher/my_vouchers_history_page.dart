import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/home/transactions/transaction_detail_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/shop/marketplace_request.dart';
import 'package:resiklos/shop/voucher_model.dart';
import 'package:resiklos/utils/constants.dart';

class MyVoucherHistoryPage extends StatefulWidget {
  const MyVoucherHistoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyVoucherPageState();
}

class _MyVoucherPageState extends State<MyVoucherHistoryPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  List<VoucherModel> _lists = [];
  int _pageNum = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var list = await MarketPlaceRequest.claimedVoucher(true, _pageNum);
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
    log("merchant list --->>$list");
    setState(() {});
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
                VoucherModel model = _lists[index];
                return Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Transfer Out",
                                      style: const TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${model.amount} RP",
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${model.merchant ?? DateTime.now()}",
                                      style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontSize: 12),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "123",
                                        style: TextStyle(
                                            color: Color(0xffD4D4D4),
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        //   return TransactionDetailPage(model: model)
                        // }));
                      },
                      behavior: HitTestBehavior.opaque,
                    ));
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
