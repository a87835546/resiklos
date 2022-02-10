import 'package:flutter/material.dart';
import 'package:resiklos/app_tab_bar.dart';
import 'package:resiklos/game/game_page.dart';
import 'package:resiklos/scan/scan_page.dart';

import 'home/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _Demo2PageState createState() => _Demo2PageState();
}

class _Demo2PageState extends State<CustomBottomNavigationBar> {
  int page = 1;

  PageController pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ScanPage(),
            HomePage(
              model: null,
            ),
            GamePage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        child: AppTabBar(bottom: MediaQuery.of(context).padding.bottom,click: (index){
          setState(() {
            page = index;
          });
          pageController.jumpToPage(page);
        },),
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
    pageController.jumpToPage(page);
  }
}
