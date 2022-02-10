import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:resiklos/sign_up_in/onboarding_swiper_item_widget.dart';
import 'package:resiklos/sign_up_in/sign_button.dart';
import 'package:resiklos/sign_up_in/sign_in.dart';
import 'package:resiklos/sign_up_in/sign_up.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<SwiperModel> _list = [
    SwiperModel("PLAY",
        "Participate in our Treasure Hunting Game to organize wastes in a fun way"),
    SwiperModel("SAVE",
        "The more we save the environment the more we can achieve sustainability"),
    SwiperModel("EARN",
        "Playing while saving the environment can boost your financial portfolio"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        child: Container(
          decoration:const BoxDecoration(
            color: Color(0xff00BEBE),
            image: DecorationImage(
              image: AssetImage("imgs/onboarding-bg.png"),
              fit: BoxFit.fill
            )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  child: Container(
                    child: Image.asset(
                      "imgs/onboarding-mascot.png",
                      width: 246,
                      height: 175,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return OnboardingSwiperItemWidget(
                          model: _list[index],
                        );
                      },
                      itemCount: _list.length,
                      autoplay: true,
                      autoplayDelay: 1,
                      //自定义指示器
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(right: 0, bottom: 0),
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white54,
                              size: 10,
                              activeSize: 10,
                              activeColor: Colors.white))),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 120,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SignButton(
                            width: 250,
                            disable: true,
                            title: "LOGIN",
                            click: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return SignInPage();
                                  }));
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        SignButton(
                            bgColor: Color(0xff0CC9BE),
                            width: 250,
                            disable: true,
                            title: "SIGN UP",
                            click: () async {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     fullscreenDialog: true,
                              //     builder: (context) {
                              //       return SignUpPage();
                              //     }));
                              Navigator.push(
                                context,
                                jump(SignUpPage())
                              );
                            }),
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "imgs/logo@2x.png",
                            width: 46,
                            height: 46,
                          ),
                        ),
                        Container(
                          child: const Text(
                            "RESIKLOS",
                            style: TextStyle(
                                color: Color(0xff00A6BE),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          child: const Text(
                            "www.resiklos.com",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 10),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
        removeTop: true,
        removeBottom: true,
      ),
    );
  }


  Route jump(Widget page) {
    return PageRouteBuilder(
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) =>
            page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return
            SlideTransition(
              position:
              // animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
              Tween<Offset>(begin: Offset(0,1),end: Offset(0,0)).animate(animation),
              child: child,
            );
        });
  }
}

class SwiperModel {
  String title;
  String desc;

  SwiperModel(this.title, this.desc);
}
