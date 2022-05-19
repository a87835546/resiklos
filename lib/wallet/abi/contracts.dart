import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/wallet/abi/rsg.g.dart';
import 'package:resiklos/wallet/abi/rsgt.g.dart';
import 'package:resiklos/wallet/abi/usdt.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

/// wallet client:
Client httpClient = Client();
const bool _debug = kDebugMode;

const String rpcUrl = _debug
    ? 'https://speedy-nodes-nyc.moralis.io/48a08ed130f404bef87433b9/bsc/testnet'
    : "https://speedy-nodes-nyc.moralis.io/48a08ed130f404bef87433b9/bsc/mainnet";
const int chainId = _debug ? 97 : 56;

var wsUrl = _debug
    ? "wss://speedy-nodes-nyc.moralis.io/48a08ed130f404bef87433b9/bsc/testnet/ws"
    : "wss://speedy-nodes-nyc.moralis.io/48a08ed130f404bef87433b9/bsc/mainnet/ws";

Web3Client client = Web3Client(rpcUrl, httpClient, socketConnector: () {
  return IOWebSocketChannel.connect(wsUrl).cast<String>();
});
Web3Client ethClient = Web3Client(rpcUrl, httpClient);

class Bep20Token {
  Bep20Token();

  static Rsgt rsgt =
      Rsgt(address: RSGT.contractAddress, client: client, chainId: chainId);
  static Usdt usdt =
      Usdt(address: USDT.contractAddress, client: client, chainId: chainId);
  static Rsg rsg =
      Rsg(address: RSG.contractAddress, client: client, chainId: chainId);

  static Future<DeployedContract> loadContract(Token token) async {
    String abiCode = await rootBundle.loadString(token.abi);

    final contract = DeployedContract(
        ContractAbi.fromJson(abiCode, token.name), token.contractAddress);
    return contract;
  }
}

class RSGT {
  static const name = 'RSGT';
  static const abi = 'rsgt.abi.json';
  static EthereumAddress contractAddress =
      EthereumAddress.fromHex('0x286E62f26E665D2d1CE2B2367EC41b226E661F82');
  static const decimals = 18;

  static Token getToken() {
    return Token(abi, name, contractAddress, decimals);
  }

  static Rsgt token =
      Rsgt(address: contractAddress, client: client, chainId: chainId);
}

class USDT {
  static const name = 'USDT';
  static const String abi = 'usdt.abi.json';
  static EthereumAddress contractAddress =
      EthereumAddress.fromHex('0x337610d27c682E347C9cD60BD4b3b107C9d34dDd');
  static const decimals = 18;

  static Token getToken() {
    return Token(abi, name, contractAddress, decimals);
  }

  static Usdt token =
      Usdt(address: contractAddress, client: client, chainId: chainId);
}

class RSG {
  static const name = 'RSG';
  static const String abi = 'rsg.abi.json';
  static EthereumAddress contractAddress =
      EthereumAddress.fromHex('0xD0d3e938caB22914E777EF81F5997C0BC747ebE5');
  static const decimals = 18;

  static Token getToken() {
    return Token(abi, name, contractAddress, decimals);
  }

  static Rsg token =
      Rsg(address: contractAddress, client: client, chainId: chainId);
}

class Token {
  String name;
  String abi;
  EthereumAddress contractAddress;
  int decimals = 18;

  Token(this.abi, this.name, this.contractAddress, this.decimals);
}

class Blockchain {
  static String? privateKey;
  static String? ownAddress;
  static String? recipientAddress;
  static Credentials? credentials;

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<String> createNewWallet(String seedphrase,
      {String password = 'resiklos'}) async {
    // Generate a new key randomly
    Random randomKey = Random.secure();
    EthPrivateKey credentials;

    String privateKeyFromSeedphrase = getPrivateKeyFromSeedphrase(seedphrase);
    credentials = EthPrivateKey.fromHex(privateKeyFromSeedphrase);

    EthereumAddress address = await credentials.extractAddress();

    Wallet wallet = Wallet.createNew(credentials, password, randomKey);
    SharedPreferences prefs = await _prefs;
    await prefs.setString('wallet', wallet.toJson());

    debugPrint('Wallet Saved and Generated: $address');

    return address.hex;
  }

  static Future<Credentials> loadWallet({String password = 'resiklos'}) async {
    SharedPreferences prefs = await _prefs;

    Credentials credentials;

    try {
      String? walletContent = prefs.getString('wallet');

      if (walletContent == null) {
        throw Exception('No saved wallet');
      }

      Wallet wallet = Wallet.fromJson(walletContent, password);

      credentials = wallet.privateKey;
      EthPrivateKey privateKey = wallet.privateKey;
      debugPrint(bytesToHex(privateKey.privateKey));
      Blockchain.credentials = credentials;
      Blockchain.ownAddress = wallet.privateKey.extractAddress().toString();
      Blockchain.privateKey = bytesToHex(privateKey.privateKey);
    } catch (e, s) {
      throw Exception(e);
    }

    return credentials;
  }

  static Future<bool> clearWallet() async {
    SharedPreferences prefs = await _prefs;
    final success = await prefs.remove('wallet');

    return success;
  }

  static Future<double> estimateGasFee({String amountInEther = '1'}) async {
    EtherAmount amount =
        EtherAmount.fromUnitAndValue(EtherUnit.ether, amountInEther);
    EtherAmount gasPrice = await client.getGasPrice();

    var fee = await client.estimateGas(
      // sender: EthereumAddress.fromHex(ownAddress),
      // to: EthereumAddress.fromHex(recipientAddress),
      value: amount,
      gasPrice: gasPrice,
    );

    var gasFee = EtherAmount.fromUnitAndValue(
            EtherUnit.gwei, gasPrice.getValueInUnitBI(EtherUnit.gwei) * fee)
        .getValueInUnit(EtherUnit.ether);

    debugPrint(
        'Gas fee: $gasFee\nGas Price: ${gasPrice.getValueInUnit(EtherUnit.gwei)}');
    return gasFee;
  }

  static Future<String> getBalanceOf(String address, {dynamic token}) async {
    EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);
    dynamic balanceInWei;
    String symbol;
    double balanceInEther;

    if (token != null) {
      balanceInWei = await token.balanceOf(address);
      balanceInEther = EtherAmount.fromUnitAndValue(EtherUnit.wei, balanceInWei)
          .getValueInUnit(EtherUnit.ether);
      symbol = await token.symbol();
    } else {
      // If token is null, default return BNB coin
      balanceInWei = await client.getBalance(ethereumAddress);
      balanceInEther = balanceInWei.getValueInUnit(EtherUnit.ether);
      symbol = 'BNB';
    }

    debugPrint('You have $balanceInEther $symbol');

    return '$balanceInEther $symbol';
  }

  static Future transferBep20Token(String address, dynamic token,
      dynamic amountInEther, Credentials credentials) async {
    EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);

    var d = await token.decimals();
    int decimals = int.parse(d.toString());

    // Get amount in Wei
    BigInt amount = BigInt.from(
        double.parse(amountInEther) * BigInt.from(10).pow(decimals).toDouble());

    // listen for the Transfer event when it's emitted by the contract above

    var transaction =
        await token.transfer(ethereumAddress, amount, credentials: credentials);
    debugPrint(
        'TransactionId: $transaction,\nSent by: $address,\namount: $amount');
    // return transaction;
    return Future.value(transaction);
  }

  static String generateSeedPhrase() {
    // uses HEX strings for entropy
    String randomMnemonic = bip39.generateMnemonic();
    debugPrint("randomMnemonic ---->>>>>>$randomMnemonic");

    return randomMnemonic;
  }

  static String getPrivateKeyFromSeedphrase(String seedphrase) {
    var seed = bip39.mnemonicToSeed(seedphrase);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/60'/0'/0/0");
    return bytesToHex(child.privateKey!, include0x: true);
  }
}
