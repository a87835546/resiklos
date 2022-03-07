import 'dart:developer';

import 'package:resiklos/home/setting/setting_request.dart';

class UserInfoModel {
  late bool? gender;
  String? avatar;
  num? userId;
  num? id;
  String? nickName;
  String? realName;
  dynamic registerTime;
  String? available;
  String? mobile;
  String? email;
  String? token;
  String? inviteCode;
  String? ipAddress;
  String? rpWalletAddress;
  String? walletAddress;
  dynamic createTime;
  dynamic lastLoginTime;
  num? deviceType;
  num? gems;
  num? verifyTime;
  bool? verifiedEmail;
  bool? verifyId;

  UserInfoModel(
      {this.id,
      this.avatar,
      this.gender,
      this.userId,
      this.nickName,
      this.realName,
      this.registerTime,
      this.available,
      this.mobile,
      this.email,
      this.deviceType,
      this.gems,
      this.verifyTime,
      this.token,
      this.ipAddress,
      this.inviteCode,
      this.createTime,
      this.lastLoginTime,
      this.rpWalletAddress,
      this.walletAddress,
      this.verifiedEmail,
      this.verifyId});

  static UserInfoModel jsonToObject(Map<String, dynamic> map) {
    log("map -- >>> $map");
    UserInfoModel model = UserInfoModel(
      gender: map['gender'],
      id: map['id'],
      userId: map['socialUserID'],
      nickName: map['userName'],
      realName: map['fullName'],
      createTime: map['createTime'],
      registerTime: map['registerTime'],
      available: map['available'],
      mobile: map['mobile'],
      email: map['email'],
      token: map['token'],
      avatar: map['avatar'],
      deviceType: map['deviceType'],
      gems: map['gems'],
      verifyTime: map['verifyTime'],
      inviteCode: map['inviteCode'],
      ipAddress: map['ipAddress'],
      lastLoginTime: map['lastLoginTime'],
      rpWalletAddress: map['rpWalletAddress'],
      walletAddress: map['walletAddress'],
      verifiedEmail: map['verifiedEmail'],
      verifyId: map['verifyId'],
    );
    log("model --- >>> $model");
    return model;
  }

  static UserInfoModel jsonToObject1(Map<String, dynamic> map) {
    log("map -- >>> $map");
    UserInfoModel model = UserInfoModel(
      gender: map['gender'],
      id: map['id'],
      userId: map['socialUserID'],
      nickName: map['nickName'],
      realName: map['fullName'],
      createTime: map['createTime'],
      registerTime: map['registerTime'],
      available: map['available'],
      mobile: map['mobile'],
      email: map['email'],
      token: map['token'],
      avatar: map['avatar'],
      deviceType: map['deviceType'],
      gems: map['gems'],
      verifyTime: map['verifyTime'],
      inviteCode: map['inviteCode'],
      ipAddress: map['ipAddress'],
      lastLoginTime: map['lastLoginTime'],
      rpWalletAddress: map['rpWalletAddress'],
      walletAddress: map['walletAddress'],
      verifiedEmail: map['verifiedEmail'],
      verifyId: map['verifyId'],
    );
    return model;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['gender'] = gender;
    data['available'] = available;
    data['realName'] = realName;
    data['createTime'] = createTime;
    data['mobile'] = mobile;
    data['available'] = available;
    data['email'] = email;
    data['token'] = token;
    data['nickName'] = nickName;
    data['deviceType'] = deviceType;
    data['gems'] = gems;
    data['verifyTime'] = verifyTime;
    data['ipAddress'] = ipAddress;
    data['inviteCode'] = inviteCode;
    data['lastLoginTime'] = lastLoginTime;
    data['verifyId'] = verifyId;
    data['verifiedEmail'] = verifiedEmail;
    data['walletAddress'] = walletAddress;
    data['rpWalletAddress'] = rpWalletAddress;
    return data;
  }

  @override
  String toString() {
    return 'UserInfoModel{gender: $gender, avatar: $avatar, userId: $userId, id: $id, nickName: $nickName, realName: $realName, registerTime: $registerTime, available: $available, mobile: $mobile, email: $email, token: $token, inviteCode: $inviteCode, ipAddress: $ipAddress, rpWalletAddress: $rpWalletAddress, walletAddress: $walletAddress, createTime: $createTime, lastLoginTime: $lastLoginTime, deviceType: $deviceType, gems: $gems, verifyTime: $verifyTime, verifiedEmail: $verifiedEmail, verifyId: $verifyId}';
  }
}
