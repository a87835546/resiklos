import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/home/transactions/transaction_request.dart';
import 'package:resiklos/utils/app_singleton.dart';

/// 交易记录的类型
enum WalletTransactionType {
  rewards,
  transfer,
  exchange,
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
      child: ListView.builder(
        itemBuilder: (context, index) {
          TransactionModel model = _lists[index];
          String? title = model.source == 0 ? "Registration" : null;
          title = model.source == 1 ? "Referral" : title;
          title = model.source == 5 ? "Other" : title;
          return Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
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
                            title != null
                                ? title!
                                : (model.receiveAddress ==
                                        AppSingleton
                                            .userInfoModel?.rpWalletAddress
                                    ? "Transfer In"
                                    : "Transfer Out"),
                            style: TextStyle(
                                color: title != null
                                    ? Color(0xff707070)
                                    : (model.receiveAddress ==
                                            AppSingleton
                                                .userInfoModel?.rpWalletAddress
                                        ? Colors.redAccent
                                        : Colors.greenAccent),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.point} RP",
                              style: const TextStyle(
                                  color: Color(0xff707070),
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
                            "${model.createAt ?? DateTime.now()}",
                            style: TextStyle(
                                color: Color(0xffD4D4D4), fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${model.source == 0 ? "Admin" : (model.source == 2 ? "Transfer ${model.userName ?? ""} " : "Referral")}",
                              style: TextStyle(
                                  color: Color(0xffD4D4D4), fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
      if (result.length > 0 && _pageNum > 1) {
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
