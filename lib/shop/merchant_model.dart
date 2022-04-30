class MerchantModel {
  int? id;
  String? name;
  String? code;
  int? logo;
  String? logoUrl;
  String? contactNumber;
  int? industry;
  String? industryName;
  int? subIndustry;
  String? subIndustryName;
  int? country;
  String? countryName;
  int? province;
  String? provinceName;
  int? city;
  String? cityName;
  String? postalCode;
  String? address1;
  String? address2;
  List<int>? documents;
  List<DocumentsList>? documentsList;
  String? createdAt;
  String? updatedAt;

  MerchantModel(
      {this.id,
      this.name,
      this.code,
      this.logo,
      this.logoUrl,
      this.contactNumber,
      this.industry,
      this.industryName,
      this.subIndustry,
      this.subIndustryName,
      this.country,
      this.countryName,
      this.province,
      this.provinceName,
      this.city,
      this.cityName,
      this.postalCode,
      this.address1,
      this.address2,
      this.documents,
      this.documentsList,
      this.createdAt,
      this.updatedAt});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    logo = json['logo'];
    logoUrl = json['logo_url'];
    contactNumber = json['contact_number'];
    industry = json['industry'];
    industryName = json['industry_name'];
    subIndustry = json['sub_industry'];
    subIndustryName = json['sub_industry_name'];
    country = json['country'];
    countryName = json['country_name'];
    province = json['province'];
    provinceName = json['province_name'];
    city = json['city'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    documents = json['documents'].cast<int>();
    if (json['documents_list'] != null) {
      documentsList = <DocumentsList>[];
      json['documents_list'].forEach((v) {
        documentsList!.add(new DocumentsList.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['logo'] = this.logo;
    data['logo_url'] = this.logoUrl;
    data['contact_number'] = this.contactNumber;
    data['industry'] = this.industry;
    data['industry_name'] = this.industryName;
    data['sub_industry'] = this.subIndustry;
    data['sub_industry_name'] = this.subIndustryName;
    data['country'] = this.country;
    data['country_name'] = this.countryName;
    data['province'] = this.province;
    data['province_name'] = this.provinceName;
    data['city'] = this.city;
    data['city_name'] = this.cityName;
    data['postal_code'] = this.postalCode;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['documents'] = this.documents;
    if (this.documentsList != null) {
      data['documents_list'] =
          this.documentsList!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'MerchantModel{id: $id, name: $name, code: $code, logo: $logo, logoUrl: $logoUrl, contactNumber: $contactNumber, industry: $industry, industryName: $industryName, subIndustry: $subIndustry, subIndustryName: $subIndustryName, country: $country, countryName: $countryName, province: $province, provinceName: $provinceName, city: $city, cityName: $cityName, postalCode: $postalCode, address1: $address1, address2: $address2, documents: $documents, documentsList: $documentsList, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class DocumentsList {
  int? id;
  String? url;
  String? filename;

  DocumentsList({this.id, this.url, this.filename});

  DocumentsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['filename'] = this.filename;
    return data;
  }

  @override
  String toString() {
    return 'DocumentsList{id: $id, url: $url, filename: $filename}';
  }
}
