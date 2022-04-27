import 'dart:developer';

class TransactionModel {
  num? id;
  num? source;
  num? point;
  String? description;
  num? target;
  String? email;
  String? createAt;
  String? userName;
  num? transactionId;
  num? txId;
  String? receiveAddress;
  String? transferAddress;
  String? receivedUserName;
  String? transferUserName;
  String? note;

  TransactionModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    source = map["source"];
    point = map["amount"];
    description = map["descr"];
    target = map["target"];
    email = map["userEmail"];
    createAt = map["createAt"];
    userName = map["userName"];
    txId = map["txId"];
    transactionId = map["transactionId"];
    receiveAddress = map["receiveAddress"];
    transferAddress = map["transferAddress"];
    receivedUserName = map["receivedUserName"];
    transferUserName = map["transferUserName"];
    note = map["note"];
  }

  @override
  String toString() {
    return 'TransactionModel{id: $id, source: $source, point: $point, description: $description, target: $target, email: $email, createAt: $createAt, userName: $userName, transactionId: $transactionId, txId: $txId, receiveAddress: $receiveAddress, transferAddress: $transferAddress, receivedUserName: $receivedUserName, transferUserName: $transferUserName}';
  }
}
