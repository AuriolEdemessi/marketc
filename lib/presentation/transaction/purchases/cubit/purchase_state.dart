import 'package:marketscc/data/models/trx_model.dart';

import '../../../../export.dart';

class PurchaseState extends BaseState {
  PurchaseState({
    this.status = FormzStatus.pure,
    this.trxList
  });

  final FormzStatus status;
  final List<TrxModel>? trxList;

  @override
  List<Object?> get props => [
    status,
    trxList,
  ];

  PurchaseState copyWith({
    FormzStatus? status,
    List<TrxModel>? trxList,
  }) {
    return PurchaseState(
      status: status ?? this.status,
      trxList: trxList ?? this.trxList,
    );
  }
}
