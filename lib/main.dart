import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/sign_up_in/onboarding_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/size_fit.dart';
import 'package:resiklos/utils/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigationbar.dart';

const bool _debug = kDebugMode;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppSingleton.devMode = DevMode.staging;
  log("debug mode ---->>>>>$_debug");
  TLSizeFit.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserLoginProviderModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<UserInfoModel> snapshot) {
        if ((snapshot.hasError || snapshot.data == null) && kIsWeb == false) {
          log("loading local data error ${snapshot.error}");
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("error ${snapshot.error}"),
              ),
            ),
          );
        } else {
          UserInfoModel? model = snapshot.data;

          Future.delayed(const Duration(seconds: 0)).then((onValue) {
            BuildContext? context = navigatorKey.currentState?.overlay?.context;
            AppSingleton.currentPage = context;
          });
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Resiklos',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // primarySwatch: Color(0xff00A6BE),
                fontFamily: 'Montserrat',
              ),
              home: model?.token != null
                  ? CustomBottomNavigationBar()
                  : OnboardingPage(),
              // SignInPage(),
              color: Color(0xff00A6BE),
              builder: EasyLoading.init(),
            ),
          );
        }
      },
      future: readData(),
    );
  }

  Future<UserInfoModel> readData() async {
    log("web ---->>>>> ${Platform.isFuchsia}");

    if (Platform.isIOS) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var s = sharedPreferences.get("userinfo");
      // log("sharedPreferences get user $s");
      if (s != null && s is String) {
        Map<String, dynamic> map = json.decode(s);
        UserInfoModel model = UserInfoModel.fromJson(map);
        return Future.value(model);
      } else {
        return Future.value(UserInfoModel());
      }
    } else if (Platform.isAndroid) {
      var re = await AppSingleton.getUserInfoModel();
      re ??= UserInfoModel();
      return Future.value(re);
    } else if (kIsWeb) {
      log("web ---->>>>>");
      return Future.value(UserInfoModel());
    } else {
      return Future.value(null);
    }
  }
}
