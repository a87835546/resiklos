import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_list.dart';
import 'package:resiklos/home/transactions/transaction_request.dart';
import 'package:resiklos/home/transactions/transaction_segment_view.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/event_bus_util.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final PageController _pageController = PageController();
  List list = [
    'TRANSFERS',
    'REWARDS',
    'PURCHASES',
    // 'EXCHANGES',
  ];
  List pages = const [
    WalletTransactionListView(
      type: WalletTransactionType.transfer,
    ),
    WalletTransactionListView(type: WalletTransactionType.rewards),
    WalletTransactionListView(type: WalletTransactionType.purchase),
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "TRANSACTIONS",
      ),
      body: Column(
        children: [
          DepositTransactionSegmentView(
            index: _index,
            isVoucher: false,
            click: (index) {
              log("$index");
              setState(() {
                _index = index;
              });
              _pageController.jumpToPage(index);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                60 -
                kToolbarHeight -
                kBottomNavigationBarHeight -
                15,
            child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                  log("on page changed $value");
                  EventBusUtil.fire(ChangeSegmentIndexEvent(value));
                },
                children: list.map((e) {
                  return Container(child: pages[list.indexOf(e)]);
                }).toList()),
          )
        ],
      ),
    );
  }

  void getData() async {
    var result = await TransactionRequest.queryTransaction(1, 1);
    log("result --->>>>$result");
  }
}
