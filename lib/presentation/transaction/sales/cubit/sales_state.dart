import '../../../../data/models/trx_model.dart';
import '../../../../export.dart';

class SalesState extends BaseState {
  SalesState({
    this.status = FormzStatus.pure,
    this.trxList,
  });

  final FormzStatus status;
  final List<TrxModel>? trxList;

  @override
  List<Object?> get props => [
    status,
    trxList
  ];

  SalesState copyWith({
    FormzStatus? status,
    List<TrxModel>? trxList,
  }) {
    return SalesState(
      status: status ?? this.status,
      trxList: trxList ?? this.trxList,
    );
  }
}
