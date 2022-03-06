import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/shop/shop_voucher_item.dart';

class ShopVoucherPage extends StatefulWidget {
  const ShopVoucherPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopVoucherPageState();
}

class _ShopVoucherPageState extends State<ShopVoucherPage> {
  final RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
        body: SmartRefresher(
      controller: _controller,
      enablePullDown: true,
      enablePullUp: true,
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [0, 1, 2, 3, 4, 5, 6].map((e) {
              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ShopVoucherItem(),
              );
            }).toList(),
          )
        ],
      ),
      onRefresh: () {
        _controller.refreshCompleted();
      },
      onLoading: () {
        _controller.loadComplete();
      },
    ));
  }
}
