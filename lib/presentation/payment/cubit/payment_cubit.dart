import '../../../export.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final HomeScreenUseCase homeScreenUseCase;

  PaymentCubit(
    this.homeScreenUseCase,
  ) : super(PaymentState());

  FedaPayTransaction? fedaPayTransaction = FedaPayTransaction();

  FedaPayTransaction? get getFedaPayTransaction => fedaPayTransaction;

  Future<void> getTransactionDetails({idTransaction}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getTransactionDetails(idTransaction);
    result.fold((failure) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: failure));
    }, (data) {
      emit(state.copyWith(
        transactionStatus: data,
        status: FormzStatus.submissionSuccess,
      ));
    });
  }
}
