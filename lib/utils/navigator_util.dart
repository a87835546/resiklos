import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resiklos/sign_up_in/sign_in.dart';
import 'package:resiklos/utils/app_singleton.dart';

class NavigatorUtil {
  static push(context, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return widget;
    }));
  }

  static pushLogin() {
    var context = AppSingleton.currentPage ?? AppSingleton.queue?.last;
    if (context != null) {
      try{
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          AppSingleton.queue = Queue();
          return SignInPage();
        }));
      }catch(e){
        log("push login page has error");
      }
    }
  }

  static pop(context) {
    Navigator.pop(context, null);
  }
}
