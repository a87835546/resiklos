class WalletModel {
  String? publicKey;
  String? lastUpdate;
  num? walletIncome;
  num? walletOutcome;
  String? userId;
  String? seedPhrase;
  String? walletAddress;
  num? balanceFee;

  WalletModel(
      {publicKey,
      lastUpdate,
      walletIncome,
      walletOutcome,
      userId,
      seedPhrase,
      walletAddress,
      balanceFee});

  WalletModel.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    lastUpdate = json['lastUpdate'];
    walletIncome = json['walletIncome'];
    walletOutcome = json['walletOutcome'];
    userId = json['userId'];
    seedPhrase = json['seedPhrase'];
    walletAddress = json['walletAddress'];
    balanceFee = json['balanceFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['publicKey'] = publicKey;
    data['lastUpdate'] = lastUpdate;
    data['walletIncome'] = walletIncome;
    data['walletOutcome'] = walletOutcome;
    data['userId'] = userId;
    data['seedPhrase'] = seedPhrase;
    data['walletAddress'] = walletAddress;
    data['balanceFee'] = balanceFee;
    return data;
  }
}
