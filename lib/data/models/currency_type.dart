import 'package:marketscc/data/models/currencies.dart';

class CurrencyType {
  int? currencyTypeId;
  String? currencyTypeName;
  int? status;
  List<Currencies>? currencies;

  CurrencyType(
      {this.currencyTypeId,
      this.currencyTypeName,
      this.status,
      this.currencies});

  CurrencyType.fromJson(Map<String, dynamic> json) {
    currencyTypeId = json['currency_type_id'];
    currencyTypeName = json['currency_type_name'];
    status = json['status'];
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(new Currencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_type_id'] = this.currencyTypeId;
    data['currency_type_name'] = this.currencyTypeName;
    data['status'] = this.status;
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
