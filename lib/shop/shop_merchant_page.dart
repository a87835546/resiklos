import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopMerchantPage extends StatefulWidget {
  const ShopMerchantPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopMerchantPageState();
}

class _ShopMerchantPageState extends State<ShopMerchantPage> {
  final RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SmartRefresher(
      controller: _controller,
      enablePullDown: true,
      enablePullUp: true,
      child: Center(
        child: Text("MERCHANTS"),
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
