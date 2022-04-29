import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/event_bus_util.dart';

typedef DepositTransactionSegmentViewClick = Function(int);

class DepositTransactionSegmentView extends StatefulWidget {
  final DepositTransactionSegmentViewClick click;
  final int index;
  final bool isShop;
  final List<String>? titles;

  const DepositTransactionSegmentView(
      {Key? key,
      required this.click,
      required this.index,
      required this.isShop,
      this.titles})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionSegmentViewState();
}

class _DepositTransactionSegmentViewState
    extends State<DepositTransactionSegmentView>
    with SingleTickerProviderStateMixin {
  StreamSubscription? _streamSubscription;

  var select = "TRANSFERS";
  static List list = [
    'TRANSFERS',
    'REWARDS',
    'PURCHASES',
  ];
  double leftPadding = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (widget.isShop) {
      list = ["MERCHANTS", "VOUCHERS"];
      leftPadding = 50;
    } else {
      list = [
        'TRANSFERS',
        'REWARDS',
        'PURCHASES',
      ];
      leftPadding = 14;
    }
    list = widget.titles ?? list;

    _tabController = TabController(length: list.length, vsync: this);
    _streamSubscription = EventBusUtil.listen((event) {
      if (event is ChangeSegmentIndexEvent) {
        _tabController.animateTo(event.index);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      select = list[widget.index];
    });
    return Container(
      height: 60,
      padding: EdgeInsets.only(
          left: leftPadding,
          right: leftPadding,
          top: 5 + MediaQuery.of(context).padding.top,
          bottom: 5),
      color: Colors.white,
      child: TabBar(
        indicatorWeight: 5,
        indicatorColor: mainColor(),
        labelColor: mainColor(),
        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelColor: color_d4d4d4(),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.only(bottom: 5.0, left: 5, right: 5),
        onTap: (index) {
          _tabController.animateTo(index);
          widget.click(index);
        },
        tabs: list.map((e) {
          return Tab(
            text: e,
          );
        }).toList(),
        controller: _tabController,
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: list.map((e) {
      //     return DepositButton(
      //       click: (value) {
      //         setState(() {
      //           select = value;
      //         });
      //         widget.click(list.indexOf(value));
      //       },
      //       selected: select == e,
      //       title: e,
      //     );
      //   }).toList(),
      // ),
    );
  }
}
