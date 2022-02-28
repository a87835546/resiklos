import 'dart:developer';

class TransactionModel {
  num? id;
  num? source;
  num? point;
  String? description;
  num? target;
  String? email;
  String? createTime;
  String? userName;

  TransactionModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    source = map["source"];
    point = map["point"];
    description = map["description"];
    target = map["target"];
    email = map["email"];
    createTime = map["createTime"];
    userName = map["userName"];
  }

  @override
  String toString() {
    return 'TransactionModel{id: $id, source: $source, point: $point, description: $description, target: $target, email: $email, createTime: $createTime, userName: $userName}';
  }
}