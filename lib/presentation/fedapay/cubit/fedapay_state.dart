import '../../../export.dart';

class FedapayState extends BaseState {
  FedapayState({
    this.errorMessage,
    this.transactionApi,
    this.createTransactionStatus=FormzStatus.pure,
  });


  final ErrorMessage? errorMessage;
  final TransactionApi? transactionApi;
  final FormzStatus createTransactionStatus;

  @override
  List<Object?> get props => [
    errorMessage,
    transactionApi,
    createTransactionStatus,
  ];

  FedapayState copyWith({
    FormzStatus? createTransactionStatus,
    ErrorMessage? errorMessage,
    TransactionApi? transactionApi,
  }) {
    return FedapayState(
      createTransactionStatus: createTransactionStatus ?? this.createTransactionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      transactionApi: transactionApi ?? this.transactionApi,
    );
  }
}