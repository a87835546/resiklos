class WalletModel {
  String? publicKey;
  String? lastUpdate;
  num? walletIncome;
  num? walletOutcome;
  String? userId;
  String? seedPhrase;
  String? walletAddress;
  String? privateKey;
  num? balanceFee;

  WalletModel(
      {publicKey,
      lastUpdate,
      walletIncome,
      walletOutcome,
      userId,
      seedPhrase,
      walletAddress,
      privateKey,
      balanceFee});

  WalletModel.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    lastUpdate = json['lastUpdate'];
    walletIncome = json['walletIncome'];
    walletOutcome = json['walletOutcome'];
    userId = json['userId'];
    seedPhrase = json['seedPhrase'];
    walletAddress = json['address'];
    balanceFee = json['balanceFee'];
    privateKey = json['privateKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['publicKey'] = publicKey;
    data['lastUpdate'] = lastUpdate;
    data['walletIncome'] = walletIncome;
    data['walletOutcome'] = walletOutcome;
    data['userId'] = userId;
    data['seedPhrase'] = seedPhrase;
    data['walletAddress'] = walletAddress;
    data['balanceFee'] = balanceFee;
    data['privateKey'] = privateKey;
    return data;
  }
}
