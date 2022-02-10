import 'dart:developer';

import 'package:flutter/cupertino.dart';

class UserLoginProviderModel extends ChangeNotifier {

  bool? isRemember;
  String? username;
  String? password;

  void update(remember,user,pwd){
    isRemember = remember;
    username = user;
    password = pwd;
    log("user login provider model --- >>> > $isRemember $username $password");
    notifyListeners();
  }
}