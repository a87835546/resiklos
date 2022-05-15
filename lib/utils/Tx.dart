import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

const chain = 'bsc testnet';
const apiKey =
    'yyMhtXvAxUOCB6Ti03l2uTbLG2nW3PVOmGUndQFBuWmj686wXGOOceeVEEN1k9F6'; //testnet Moralis API Key

class Tx {
  String hash;
  String fromAddress;
  String toAddress;
  dynamic value;
  dynamic gas;
  dynamic gasPrice;
  dynamic receiptGasUsed;
  int receiptStatus;
  DateTime blockTimestamp;
  BigInt blockNumber;
  String blockHash;

  Tx(
      {required this.hash,
      required this.fromAddress,
      required this.toAddress,
      required this.value,
      required this.gas,
      required this.gasPrice,
      required this.receiptGasUsed,
      required this.receiptStatus,
      required this.blockTimestamp,
      required this.blockNumber,
      required this.blockHash});

  factory Tx.fromJson(Map<String, dynamic> json) {
    // log("map -- >>> $json", name: 'models/Tx');

    Tx model = Tx(
      hash: json["hash"],
      fromAddress: json["from_address"],
      toAddress: json['to_address'] ?? '',
      value: EtherAmount.fromUnitAndValue(EtherUnit.wei, json['value'])
          .getValueInUnit(EtherUnit.ether),
      gas: EtherAmount.fromUnitAndValue(EtherUnit.gwei, json['gas'])
          .getValueInUnit(EtherUnit.ether),
      gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, json['gas_price'])
          .getValueInUnit(EtherUnit.ether),
      receiptGasUsed:
          EtherAmount.fromUnitAndValue(EtherUnit.gwei, json['receipt_gas_used'])
              .getValueInUnit(EtherUnit.ether),
      receiptStatus: int.parse(json['receipt_status']),
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

    Uri uri = Uri.https('deep-index.moralis.io', '/api/v2/$address', params);
    var res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': apiKey
      },
    );

    Map<String, dynamic> body = jsonDecode(res.body);
    final result = body['result'];

    List<dynamic> tx =
        result.map((e) => Tx.fromJson(e as Map<String, dynamic>)).toList();

    return tx;
  }

  static Future<dynamic> getBalance(String address) async {
    final params = {
      "chain": chain,
      "from_block": '0',
      'order': "desc",
      'limit': '0'
    };

    Uri uri =
        Uri.https('deep-index.moralis.io', '/api/v2/$address/balance', params);
    var res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Key': apiKey
      },
    );

    Map<String, dynamic> result = jsonDecode(res.body);

    var balance = EtherAmount.fromUnitAndValue(
            EtherUnit.wei, BigInt.parse(result['balance']))
        .getValueInUnit(EtherUnit.ether);

    return balance;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Tx(hash: $hash, fromAddress: $fromAddress, toAddress: $toAddress, value: $value, gas: $gas, gasPrice: $gasPrice, receiptGasUsed: $receiptGasUsed, receiptStatus: $receiptStatus, blockHash: $blockHash)';
  }
}
