import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/home/transactions/transaction_detail_page.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/home/transactions/transaction_request.dart';
import 'package:resiklos/utils/app_singleton.dart';

/// 交易记录的类型
enum WalletTransactionType {
  rewards,
  transfer,
  exchange,
  purchase,
}

class WalletTransactionListView extends StatefulWidget {
  final WalletTransactionType type;

  const WalletTransactionListView({Key? key, required this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionListViewState();
}

class _DepositTransactionListViewState
    extends State<WalletTransactionListView> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  List<TransactionModel> _lists = [];
  int _pageNum = 1;

  @override
  void initState() {
    super.initState();
    getData();
    log("widget type --- >>> ${widget.type}");
  }

  void getData() {
    switch (widget.type) {
      case WalletTransactionType.rewards:
        {
          getRewordsTransaction(0);
          break;
        }
      case WalletTransactionType.transfer:
        {
          getRewordsTransaction(1);
          break;
        }
      case WalletTransactionType.exchange:
        {
          getRewordsTransaction(2);
          break;
        }
      case WalletTransactionType.purchase:
        {
          getRewordsTransaction(4);
          break;
        }
    }
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
              alignment: Alignment.center,
              height: 50,
              child: Text('No ${widget.type.name} record '),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                TransactionModel model = _lists[index];
                String title = model.source == 0 ? "Registration" : "";
                title = model.source == 1 ? "Referral" : title;
                title = model.source == 2 ? "Transfer" : title;
                title = model.source == 5 ? "Purchase" : title;
                title = model.source == 6 ? "Adjustment" : title;
                title = model.source == 7 ? "Other" : title;

                // "     * 积分的来源，分两种\n" +
                //     "     * 0 ---- 系统赠送\n" +
                //     "     * 1 --- 邀请他人获取\n" +
                //     "     * 2 ---- 他人转账 or 转账给他人\n" +
                //     "     * 3 ---- exchange or convert\n" +
                //     "     * 4 ---- rsg 转账\n" +
                //     "     * 5 ---- merchant\n" +
                //     "     * 6 ---- other\n" +
                bool isAdd = false;
                isAdd = model.source == 0 ? isAdd = true : isAdd;
                isAdd = model.source == 1 ? isAdd = true : isAdd;
                isAdd = model.source == 2
                    ? (model.receiveAddress ==
                            AppSingleton.userInfoModel?.rpWalletAddress
                        ? true
                        : false)
                    : isAdd;
                isAdd = model.source == 3 ? isAdd = true : isAdd;
                isAdd = model.source == 5 ? isAdd = false : isAdd;
                isAdd = model.source == 6 ? isAdd = true : isAdd;
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
                                      isAdd ? "Transfer In" : "Transfer Out",
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
                                        "${isAdd ? "+" : "-"} ${model.point} RP",
                                        style: TextStyle(
                                            color: (!isAdd
                                                ? Colors.redAccent
                                                : Colors.greenAccent),
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
                                      "${model.transactionId ?? DateTime.now()}",
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
                                        title,
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return TransactionDetailPage(model: model);
                        }));
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

  void getRewordsTransaction(type) async {
    var result = await TransactionRequest.queryTransaction(type, _pageNum);
    setState(() {
      if (_pageNum > 1) {
        _lists.addAll(result);
      } else {
        _lists = result;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (result.isEmpty && _pageNum > 1) {
        _refreshController.loadNoData();
      }
    });

    log("rewards transaction result --->>>>$result");
  }
}

class TitleConfig {
  String? title;
  Color? color;
}
