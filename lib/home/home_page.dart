import 'package:flutter/material.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_articles_widget.dart';
import 'package:resiklos/model/user_info_model.dart';

import 'home_invite_widget.dart';
import 'home_navi_widget.dart';
import 'home_top_container_widget.dart';

class HomePage extends BaseStatefulWidget  {
  final UserInfoModel? model;

  const HomePage({Key? key, required this.model}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _HomePageState();
}

class _HomePageState extends BaseStatefulState<HomePage> {
  var _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  Widget _widget(){
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Container(
              height: MediaQuery.of(context).size.height +
                  MediaQuery.of(context).padding.bottom,
              child: Column(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  HomeNaviView(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  Container(height: 15,color: Colors.transparent,),
                  Expanded(
                      child: Container(
                        padding:const EdgeInsets.only(left: 15,right: 15),
                        child: ListView(
                          // physics: NeverScrollableScrollPhysics(),
                          controller: _controller,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: 15,),
                            const HomeTopContainerView(),
                            const Padding(
                              padding:
                              EdgeInsets.only(top: 30),
                              child: HomeInviteView(),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 6, top: 30),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "ARTICLES",
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xffD4D4D4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only( top: 5,),
                              child: HomeArticlesView(
                                isResiklos: true,
                              ),
                            ),
                            const Padding(
                              padding:
                              EdgeInsets.only( top: 10, bottom: 10),
                              child: HomeArticlesView(
                                isResiklos: false,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
