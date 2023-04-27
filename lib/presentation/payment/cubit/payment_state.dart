import 'package:marketscc/export.dart';

class PaymentState extends BaseState {
  PaymentState({
    this.status=FormzStatus.pure,
    this.fedaPayTransaction,
    this.errorMessage,
    this.transactionStatus,
  });

  final ErrorMessage? errorMessage;
  final FormzStatus status;
  final FedaPayTransaction? fedaPayTransaction;
  final String? transactionStatus;

  @override
  List<Object?> get props => [
    errorMessage,
    status,
    fedaPayTransaction,
    transactionStatus,
  ];

  PaymentState copyWith({
    ErrorMessage? errorMessage,
    FormzStatus? status,
    FedaPayTransaction? fedaPayTransaction,
    String? transactionStatus,
  }) {
    return PaymentState(
      status: status ?? this.status,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      fedaPayTransaction: fedaPayTransaction ?? this.fedaPayTransaction,
    );
  }
}

