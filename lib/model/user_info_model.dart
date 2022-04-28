import 'dart:developer';

class UserInfoModel {
  String? gender;
  String? avatar;
  num? userId;
  num? id;
  String? nickName;
  String? fullName;
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
  int emailVerificationStatus;

  /// 0 unverified 1.pending 2.verified 3.rejected
  int kycVerificationStatus;
  int verificationStatus;

  UserInfoModel(
      {this.id = 0,
      this.avatar,
      this.gender = "M",
      this.userId,
      this.nickName = "R",
      this.fullName = "R",
      this.registerTime = '',
      this.available,
      this.mobile,
      this.email,
      this.deviceType,
      this.gems,
      this.token,
      this.ipAddress,
      this.inviteCode,
      this.createTime,
      this.lastLoginTime,
      this.rpWalletAddress,
      this.walletAddress = '',
      this.emailVerificationStatus = 0,
      this.kycVerificationStatus = 0,
      this.verificationStatus = 0});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    // log("map -- >>> $json", name: 'models/User');

    UserInfoModel model = UserInfoModel(
        id: json['id'],
        userId: json['userId'],
        email: json['email'],
        token: json['token'],
        inviteCode: json['inviteCode'],
        nickName: json['nickName'],
        fullName: json['userName'],
        avatar: json['avatar'],
        gender: json['gender'],
        createTime: json['createTime'],
        registerTime: json['registerTime'],
        available: json['available'],
        mobile: json['mobile'],
        gems: json['gems'],
        ipAddress: json['ipAddress'],
        lastLoginTime: json['lastLoginTime'],
        rpWalletAddress: json['rpWalletAddress'],
        walletAddress: json['walletAddress'],
        emailVerificationStatus: json['verifiedEmail'] == false ? 0 : 1,
        kycVerificationStatus: json['kycState'] ?? 0,
        verificationStatus: _getVerificationStatus(
            json['verifiedEmail'] == false ? 0 : 1, json['kycState'] ?? 0));
    return model;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['gender'] = gender;
    data['available'] = available;
    data['realName'] = fullName;
    data['createTime'] = createTime;
    data['mobile'] = mobile;
    data['available'] = available;
    data['email'] = email;
    data['token'] = token;
    data['nickName'] = nickName;
    data['deviceType'] = deviceType;
    data['gems'] = gems;
    data['ipAddress'] = ipAddress;
    data['inviteCode'] = inviteCode;
    data['lastLoginTime'] = lastLoginTime;
    data['kycState'] = verificationStatus;
    data['verifiedEmail'] = emailVerificationStatus;
    data['walletAddress'] = walletAddress;
    data['rpWalletAddress'] = rpWalletAddress;
    return data;
  }

  static int _getVerificationStatus(
      int emailVerification, int kycVerification) {
    int status = 0;

    if (emailVerification == 1) {
      status++;
    }

    if (kycVerification >= 1) {
      status++;
    }

    if (kycVerification == 2) {
      status++;
    }

    if (kycVerification == 3) {
      status--;
    }

    log('status $status kyc:$kycVerification');

    return status;
  }

  @override
  String toString() {
    return 'UserInfoModel{gender: $gender, avatar: $avatar, userId: $userId, id: $id, nickName: $nickName, fullName: $fullName, registerTime: $registerTime, available: $available, mobile: $mobile, email: $email, token: $token, inviteCode: $inviteCode, ipAddress: $ipAddress, rpWalletAddress: $rpWalletAddress, walletAddress: $walletAddress, createTime: $createTime, lastLoginTime: $lastLoginTime, deviceType: $deviceType, gems: $gems, emailVerificationStatus: $emailVerificationStatus, kycVerificationStatus: $kycVerificationStatus, verificationStatus: $verificationStatus}';
  }
}
