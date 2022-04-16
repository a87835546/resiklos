import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:resiklos/app_tab_bar.dart';
import 'package:resiklos/game/game_page.dart';
import 'package:resiklos/home/setting/setting_page.dart';
import 'package:resiklos/mine/account_page.dart';
import 'package:resiklos/mine/mine_list.dart';
import 'package:resiklos/mine/mine_page.dart';
import 'package:resiklos/scan/scan_page.dart';
import 'package:resiklos/shop/shop_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/event_bus_util.dart';
import 'package:resiklos/wallet/my_wallet_page.dart';

import 'home/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  StreamSubscription? _streamSubscription;
  int _index = 1;

  @override
  void initState() {
    super.initState();
    _streamSubscription = EventBusUtil.listen((event) {
      log("init page event listen -----------?>>>>>>>>>>> $event");
      if (event is TabBarChangeEvent) {
        setState(() {
          _index = event.index;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.resume();
  }

  @override
  Widget build(BuildContext context) {
    AppSingleton.state = this;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ProsteIndexedStack(
            index: _index,
            children: [
              IndexedStackChild(child: ShopPage()),
              IndexedStackChild(
                child: const HomePage(),
              ),
              IndexedStackChild(child: MyWalletPage()),
              IndexedStackChild(child: AccountPage()),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.store_rounded),
                label: 'MarketPlace',
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house_fill), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  label: 'My Wallet'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded), label: 'Account'),
            ],
            selectedItemColor: mainColor(),
            unselectedItemColor: mainTitleColor(),
            selectedFontSize: 13,
            unselectedFontSize: 12,
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
