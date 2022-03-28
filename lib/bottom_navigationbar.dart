import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resiklos/app_tab_bar.dart';
import 'package:resiklos/game/game_page.dart';
import 'package:resiklos/home/setting/setting_page.dart';
import 'package:resiklos/scan/scan_page.dart';
import 'package:resiklos/shop/shop_page.dart';
import 'package:resiklos/utils/app_singleton.dart';

import 'home/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int page = 1;

  PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    AppSingleton.state = this;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.transparent,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ShopPage(),
            HomePage(
              model: null,
            ),
            ShopPage(),
            SettingPage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        child: AppTabBar(
          bottom: MediaQuery.of(context).padding.bottom,
          click: (index) {
            setState(() {
              page = index;
            });
            pageController.jumpToPage(page);
          },
        ),
        removeBottom: true,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    log("page changed ---->>>>$page");
    pageController.jumpToPage(page);
  }
}
