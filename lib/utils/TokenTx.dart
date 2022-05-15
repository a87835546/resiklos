import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

const chain = 'bsc testnet';
const apiKey =
    'yyMhtXvAxUOCB6Ti03l2uTbLG2nW3PVOmGUndQFBuWmj686wXGOOceeVEEN1k9F6';

class TokenTx {
  String transactionHash;
  String address;
  String fromAddress;
  String toAddress;
  dynamic value;
  DateTime blockTimestamp;
  BigInt blockNumber;
  String blockHash;

  TokenTx(
      {required this.transactionHash,
      required this.address,
      required this.fromAddress,
      required this.toAddress,
      required this.value,
      required this.blockTimestamp,
      required this.blockNumber,
      required this.blockHash});

  factory TokenTx.fromJson(Map<String, dynamic> json) {
    // log("map -- >>> $json", name: 'models/Bep20Tx');

    TokenTx model = TokenTx(
      transactionHash: json["transaction_hash"],
      address: json['address'],
      fromAddress: json["from_address"],
      toAddress: json['to_address'],
      value: EtherAmount.fromUnitAndValue(EtherUnit.wei, json['value'])
          .getValueInUnit(EtherUnit.ether),
      blockTimestamp: DateTime.parse(json['block_timestamp']),
      blockNumber: BigInt.parse(json['block_number']),
      blockHash: json['block_hash'],
    );
    return model;
  }

  static Future<List<dynamic>> getTransactions(String address) async {
    final params = {
      "chain": chain,
      "from_block": '0',
      'order': "desc",
      'limit': '0'
    };

    Uri uri = Uri.https(
        'deep-index.moralis.io', '/api/v2/$address/erc20/transfers', params);
    var res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': apiKey
      },
    );

    Map<String, dynamic> body = jsonDecode(res.body);
    final result = body['result'];
    List<dynamic> bep20tx =
        result.map((e) => TokenTx.fromJson(e as Map<String, dynamic>)).toList();

    return bep20tx;
  }

  static Future<List<TokenBalance>> getBalances(String address) async {
    final params = {
      "chain": chain,
      "from_block": '0',
      'order': "desc",
      'limit': '0'
    };

    Uri uri =
        Uri.https('deep-index.moralis.io', '/api/v2/$address/erc20', params);
    var res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': apiKey
      },
    );

    List<dynamic> result = jsonDecode(res.body);
    List<TokenBalance> tokenBalances = result
        .map((e) => TokenBalance.fromJson(e as Map<String, dynamic>))
        .toList();

    return tokenBalances;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'TokenTx(hash: $transactionHash, fromAddress: $fromAddress, toAddress: $toAddress, value: $value, blockTimeStamp: $blockTimestamp, blockNumber: $blockNumber, blockHash: $blockHash)';
  }
}

class TokenBalance {
  String tokenAddress;
  String name;
  String symbol;
  dynamic logo;
  dynamic thumbnail;
  int decimals;
  dynamic balance;

  TokenBalance(
      {required this.tokenAddress,
      required this.name,
      required this.symbol,
      this.logo = '',
      this.thumbnail = '',
      required this.decimals,
      required this.balance});

  factory TokenBalance.fromJson(Map<String, dynamic> json) {
    // log("map -- >>> $json", name: 'models/TokenBalance');

    TokenBalance model = TokenBalance(
      tokenAddress: json['token_address'],
      name: json['name'],
      symbol: json['symbol'],
      logo: json['logo'],
      thumbnail: json['thumbnail'],
      decimals: json['decimals'],
      balance: EtherAmount.fromUnitAndValue(EtherUnit.wei, json['balance'])
          .getValueInUnit(EtherUnit.ether),
    );
    return model;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'TokenBalance(tokenAddress: $tokenAddress, name: $name, symbol: $symbol, logo: $logo, thumbnail: $thumbnail, decimals: $decimals, balance: $balance)';
  }
}
