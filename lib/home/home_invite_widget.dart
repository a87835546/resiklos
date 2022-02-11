import 'package:flutter/material.dart';
import 'package:resiklos/home/referral_share_page.dart';
import 'package:resiklos/utils/navigator_util.dart';

import 'home_referrals_page.dart';

class HomeInviteView extends StatefulWidget {
  const HomeInviteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeInviteViewState();
}

class _HomeInviteViewState extends State<HomeInviteView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(80),
              blurRadius: 5.0,
              offset: Offset(0, 4),
              spreadRadius: 1),
        ],
      ),
      // clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior:Clip.none,
        children: [
          Container(
            child: Row(
              children: [
                const SizedBox(
                  width: 150,
                ),
                Expanded(
                  child: Container(
                    padding:const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child:const Text(
                            "REFER FRIENDS",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child:const Text(
                            "GET +5 RSG",
                            style: TextStyle(
                                color: Color(0xff00DE97),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child:const Text(
                            "on every friend you invite",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: GestureDetector(
              child: Container(
                height: 50,
                padding: EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width - 30,
                decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    gradient: LinearGradient(
                        colors: [Color(0xff0CC9BE), Color(0xff00A6BE)])),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child:const Text(
                            "SHARE NOW",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(width: 10,),
                    Container(
                      child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 16,),
                    )
                  ],
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: (){
                NavigatorUtil.push(context, ReferralPage());
              },
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(left: 5, bottom: 0),
              child: Container(
                height: 100,
                width: 132,
                color: Colors.transparent,
                child: OverflowBox(
                  maxWidth: 145,
                  maxHeight: 145,
                  child: Image.asset("imgs/care@2x.png"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
