class VoucherModel {
  num? id;
  String? name;
  num? voucherCategory;
  String? voucherCategoryName;
  num? voucherSubCategory;
  String? voucherSubCategoryName;
  num? merchant;
  String? merchantName;
  String? validity;
  String? image;
  String? imageUrl;
  String? code;
  num? amount;

  VoucherModel(
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

  VoucherModel.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'VoucherModel{id: $id, name: $name, voucherCategory: $voucherCategory, voucherCategoryName: $voucherCategoryName, voucherSubCategory: $voucherSubCategory, voucherSubCategoryName: $voucherSubCategoryName, merchant: $merchant, merchantName: $merchantName, validity: $validity, image: $image, imageUrl: $imageUrl, code: $code, amount: $amount}';
  }
}
