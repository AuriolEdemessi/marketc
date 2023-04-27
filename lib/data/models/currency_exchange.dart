import 'package:equatable/equatable.dart';

class CurrencyExchangeResponse extends Equatable {

  final List<CurrencyExchange> currencyExchangeList;

  const CurrencyExchangeResponse({required this.currencyExchangeList});

  factory CurrencyExchangeResponse.fromJson(json) => CurrencyExchangeResponse(currencyExchangeList: List<CurrencyExchange>.from((json).map((x) => CurrencyExchange.fromJson(x))),);

  @override
  List<Object> get props => [currencyExchangeList];
}


class CurrencyExchange{
  int? currenciesId;
  String? currencyName;
  String? currencyAcronym;
  int? currencyTypeId;
  String? currencyTypeName;
  String? currencyImage;

  CurrencyExchange(
      {this.currenciesId,
        this.currencyName,
        this.currencyAcronym,
        this.currencyTypeId,
        this.currencyTypeName,
        this.currencyImage});

  CurrencyExchange.fromJson(Map<String, dynamic> json) {
    currenciesId = json['currencies_id'];
    currencyName = json['currency_name'];
    currencyAcronym = json['currency_acronym'];
    currencyTypeId = json['currency_type_id'];
    currencyTypeName = json['currency_type_name'];
    currencyImage = json['currency_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencies_id'] = this.currenciesId;
    data['currency_name'] = this.currencyName;
    data['currency_acronym'] = this.currencyAcronym;
    data['currency_type_id'] = this.currencyTypeId;
    data['currency_type_name'] = this.currencyTypeName;
    data['currency_image'] = this.currencyImage;
    return data;
  }
}
