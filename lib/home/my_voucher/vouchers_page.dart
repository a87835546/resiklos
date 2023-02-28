import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/my_voucher/my_claimed_vouchers_page.dart';
import 'package:resiklos/home/my_voucher/my_vouchers_history_page.dart';
import 'package:resiklos/home/transactions/transaction_list.dart';
import 'package:resiklos/home/transactions/transaction_request.dart';
import 'package:resiklos/home/transactions/transaction_segment_view.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/event_bus_util.dart';

class MyVouchersPage extends StatefulWidget {
  const MyVouchersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyVouchersPageState();
}

class _MyVouchersPageState extends State<MyVouchersPage> {
  final PageController _pageController = PageController();
  List list = [
    'CLAIMED',
    'HISTORY',
  ];
  List pages = const [MyClaimedVouchersPage(), MyVoucherHistoryPage()];
  int _index = 0;

  @override
  void initState() {
    super.initState();
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
        title: "MY VOUCHERS",
      ),
      body: Column(
        children: [
          DepositTransactionSegmentView(
            index: _index,
            isVoucher: true,
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
                15 -
                kToolbarHeight -
                kBottomNavigationBarHeight,
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
}
