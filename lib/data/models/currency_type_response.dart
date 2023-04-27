import 'package:equatable/equatable.dart';

import 'currency_type.dart';

class CurrencyTypeResponse extends Equatable {

  final List<CurrencyType> currencyTypeList;

  const CurrencyTypeResponse({required this.currencyTypeList});

  factory CurrencyTypeResponse.fromJson(json) => CurrencyTypeResponse(currencyTypeList: List<CurrencyType>.from((json).map((x) => CurrencyType.fromJson(x))),);

  @override
  List<Object> get props => [currencyTypeList];
}