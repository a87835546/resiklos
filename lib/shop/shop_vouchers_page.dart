import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/shop/marketplace_request.dart';
import 'package:resiklos/shop/shop_voucher_item.dart';
import 'package:resiklos/shop/voucher_model.dart';

class ShopVoucherPage extends StatefulWidget {
  final int id;

  const ShopVoucherPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopVoucherPageState();
}

class _ShopVoucherPageState extends State<ShopVoucherPage> {
  final RefreshController _controller = RefreshController();
  List<VoucherModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _controller,
      enablePullDown: true,
      enablePullUp: true,
      child: ListView(
        shrinkWrap: true,
        children: [
          ListView(
            shrinkWrap: true,
            children: _list.map((e) {
              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ShopVoucherItem(
                  model: e,
                ),
              );
            }).toList(),
          )
        ],
      ),
      onRefresh: () {
        getData();
        _controller.refreshCompleted();
      },
      onLoading: () {
        _controller.loadComplete();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var list1 = await MarketPlaceRequest.getVoucherList(widget.id);
    setState(() {
      _list = list1;
    });
  }
}
