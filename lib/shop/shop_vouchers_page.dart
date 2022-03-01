import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        body: SmartRefresher(
          controller: _controller,
          enablePullDown: true,
          enablePullUp: true,
          child: Center(
            child: Text("VOUCHERS"),
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
