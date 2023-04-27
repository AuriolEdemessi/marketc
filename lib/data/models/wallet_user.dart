class WalletUser {
  int? id;
  int? status;
  CurrencyTypeUser? currencyType;
  CurrencyUser? currency;
  String? address;
  int? totalSale;
  int? totalPurchase;
  String? createdAt;

  WalletUser(
      {this.id,
        this.status,
        this.currencyType,
        this.currency,
        this.address,
        this.totalSale,
        this.totalPurchase,
        this.createdAt});

  WalletUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    currencyType = json['currency_type'] != null
        ? new CurrencyTypeUser.fromJson(json['currency_type'])
        : null;
    currency = json['currency'] != null
        ? new CurrencyUser.fromJson(json['currency'])
        : null;
    address = json['address'];
    totalSale = json['total_sale'];
    totalPurchase = json['total_purchase'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.currencyType != null) {
      data['currency_type'] = this.currencyType!.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['address'] = this.address;
    data['total_sale'] = this.totalSale;
    data['total_purchase'] = this.totalPurchase;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CurrencyTypeUser {
  int? id;
  String? name;

  CurrencyTypeUser({this.id, this.name});

  CurrencyTypeUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class CurrencyUser {
  int? id;
  String? name;
  String? acronym;

  CurrencyUser({this.id, this.name, this.acronym});

  CurrencyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['acronym'] = this.acronym;
    return data;
  }
}