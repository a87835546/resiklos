class KycModel {
  int? id;
  int? userId;
  String? lastName;
  String? firstName;
  String? birthday;
  String? mobile;
  bool? gender;
  String? country;
  String? idFontUrl;
  String? idBackUrl;
  String? selfieUrl;
  String? createTime;
  int? idType;
  int? verifierState;
  String? kycId;

  KycModel(
      {this.id,
      this.userId,
      this.lastName,
      this.kycId,
      this.firstName,
      this.birthday,
      this.mobile,
      this.gender,
      this.country,
      this.idFontUrl,
      this.idBackUrl,
      this.selfieUrl,
      this.createTime,
      this.idType,
      this.verifierState});

  KycModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    birthday = json['birthday'];
    mobile = json['mobile'];
    gender = json['gender'];
    country = json['country'];
    idFontUrl = json['idFontUrl'];
    idBackUrl = json['idBackUrl'];
    selfieUrl = json['selfieUrl'];
    createTime = json['createTime'];
    idType = json['idType'];
    verifierState = json['verifierState'];
    kycId = json['kycId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['birthday'] = this.birthday;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['idFontUrl'] = this.idFontUrl;
    data['idBackUrl'] = this.idBackUrl;
    data['selfieUrl'] = this.selfieUrl;
    data['createTime'] = this.createTime;
    data['idType'] = this.idType;
    data['verifierState'] = this.verifierState;
    data['kycId'] = this.kycId;
    return data;
  }

  @override
  String toString() {
    return 'KycModel{id: $id, userId: $userId, lastName: $lastName, firstName: $firstName, birthday: $birthday, mobile: $mobile, gender: $gender, country: $country, idFontUrl: $idFontUrl, idBackUrl: $idBackUrl, selfieUrl: $selfieUrl, createTime: $createTime, idType: $idType, verifierState: $verifierState, kycId: $kycId}';
  }
}
