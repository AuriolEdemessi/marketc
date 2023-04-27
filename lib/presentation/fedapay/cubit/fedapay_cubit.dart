import '../../../export.dart';

class FedapayCubit extends Cubit<FedapayState> {
  final HomeScreenUseCase homeScreenUseCase;

  FedapayCubit(
    this.homeScreenUseCase,
  ) : super(FedapayState());

  FedaPayTransaction? fedaPayTransaction = FedaPayTransaction();

  FedaPayTransaction? get getFedaPayTransaction => fedaPayTransaction;

  /*Future<void> createTransaction({body, token, idTransaction}) async {

    emit(state.copyWith(
        createTransactionStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.createTransaction(body, token);
    result.fold((failure) {
      emit(state.copyWith(
          createTransactionStatus: FormzStatus.submissionFailure,
          errorMessage: failure));
    }, (data) async{
      fedaPayTransaction = data;
      final result = await homeScreenUseCase.getUrlTransaction(data.id, token);
      result.fold((failure) {
        emit(state.copyWith(
            createTransactionStatus: FormzStatus.submissionFailure,
            errorMessage: failure));
      },(result){
        emit(state.copyWith(
          urlTransaction: result,
        createTransactionStatus: FormzStatus.submissionSuccess,
      ));
      });

    });
  }
*/
  Future<void> getUrlTransaction(
      {required int userId, required int trxId}) async {
    Map<String, dynamic> body = {"user_id": userId, "trx_id": trxId};

    emit(
        state.copyWith(createTransactionStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getUrlTransaction(body);
    result.fold((failure) {
      emit(state.copyWith(
          createTransactionStatus: FormzStatus.submissionFailure,
          errorMessage: failure));
    }, (data) {
      emit(state.copyWith(
        transactionApi: data,
        createTransactionStatus: FormzStatus.submissionSuccess,
      ));
    });
  }
}
