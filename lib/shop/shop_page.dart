import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_segment_view.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/shop/shop_merchant_page.dart';
import 'package:resiklos/shop/shop_vouchers_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final PageController _pageController = PageController();
  List list = [
    'MERCHANTS',
    'GET VOUCHERS',
  ];
  List pages = const [ShopMerchantPage(), ShopVoucherPage()];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Coming soon"),
    ));
  }

  Widget _widget() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        DepositTransactionSegmentView(
          index: _index,
          isShop: true,
          click: (index) {
            log("$index");
            setState(() {
              _index = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
        Container(
          height: MediaQuery.of(context).size.height -
              60 -
              kToolbarHeight -
              kBottomNavigationBarHeight,
          child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _index = value;
                });
                log("on page changed $value");
              },
              children: list.map((e) {
                return Container(child: pages[list.indexOf(e)]);
              }).toList()),
        )
      ],
    );
  }
}
