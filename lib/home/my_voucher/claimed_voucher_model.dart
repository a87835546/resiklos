import 'package:resiklos/shop/voucher_model.dart';

class ClaimedVoucherModel {
  num? id;
  String? email;
  String? reference;
  VoucherModel? voucher;
  String? voucherCode;
  bool? isUsed;

  ClaimedVoucherModel(
      {this.id,
      this.email,
      this.reference,
      this.voucher,
      this.voucherCode,
      this.isUsed});

  ClaimedVoucherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    reference = json['reference'];
    voucher = json['voucher'] != null
        ? new VoucherModel.fromJson(json['voucher'])
        : null;
    voucherCode = json['voucher_code'];
    isUsed = json['is_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['reference'] = this.reference;
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    data['voucher_code'] = this.voucherCode;
    return data;
  }
}

class Voucher {
  int? id;
  String? name;
  int? voucherCategory;
  String? voucherCategoryName;
  int? voucherSubCategory;
  String? voucherSubCategoryName;
  int? merchant;
  String? merchantName;
  String? validity;
  int? image;
  String? imageUrl;
  String? code;
  int? amount;

  Voucher(
      {this.id,
      this.name,
      this.voucherCategory,
      this.voucherCategoryName,
      this.voucherSubCategory,
      this.voucherSubCategoryName,
      this.merchant,
      this.merchantName,
      this.validity,
      this.image,
      this.imageUrl,
      this.code,
      this.amount});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    voucherCategory = json['voucher_category'];
    voucherCategoryName = json['voucher_category_name'];
    voucherSubCategory = json['voucher_sub_category'];
    voucherSubCategoryName = json['voucher_sub_category_name'];
    merchant = json['merchant'];
    merchantName = json['merchant_name'];
    validity = json['validity'];
    image = json['image'];
    imageUrl = json['image_url'];
    code = json['code'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['voucher_category'] = this.voucherCategory;
    data['voucher_category_name'] = this.voucherCategoryName;
    data['voucher_sub_category'] = this.voucherSubCategory;
    data['voucher_sub_category_name'] = this.voucherSubCategoryName;
    data['merchant'] = this.merchant;
    data['merchant_name'] = this.merchantName;
    data['validity'] = this.validity;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['code'] = this.code;
    data['amount'] = this.amount;
    return data;
  }
}
