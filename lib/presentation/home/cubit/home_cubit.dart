import '../../../export.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeScreenUseCase homeScreenUseCase;
  final AuthenticationUseCase authenticationUseCase;
  HomeCubit({required this.homeScreenUseCase, required this.authenticationUseCase}) : super(HomeState());

  TrxResponse trxResponse = TrxResponse();
  TrxResponse get getTrxResponse => trxResponse;

  Future<void> fetchTransaction() async {
    emit(state.copyWith(trxStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.fetchTransaction();

    result.fold((failure) {
      emit(state.copyWith(trxStatus: FormzStatus.submissionFailure, errorMessage: failure));
    }, (data) {
      trxResponse = data;
      emit(state.copyWith(trxStatus: FormzStatus.submissionSuccess, trxResponse: data));

    });
  }

  Future<void> fetchBrandImage() async {
    emit(state.copyWith(brandStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.brandImage();

    result.fold((failure) {
      emit(state.copyWith(brandStatus: FormzStatus.submissionFailure, errorMessage: failure));
    }, (data) {
      emit(state.copyWith(brandStatus: FormzStatus.submissionSuccess, brandImage: data));

    });
  }

  Future<void> deleteTransaction(String trxId) async {
    emit(state.copyWith(brandStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.deleteTransaction(trxId);

    /*result.fold((failure) {
      emit(state.copyWith(brandStatus: FormzStatus.submissionFailure, errorMessage: failure));
    }, (data) {
      emit(state.copyWith(brandStatus: FormzStatus.submissionSuccess, brandImage: data));

    });*/
  }

  setTrxResponse(data){
    trxResponse = data;
  }

 /* Future<void> fetchUser() async {
    emit(
      HomeState(
        userDataStatus: FormzStatus.submissionInProgress,
      ),
    );
    final result = await authenticationUseCase.getUser();

    result.fold((failure) {
      emit(
        HomeState(
          userDataStatus: FormzStatus.submissionFailure,

        ),
      );
    }, (data) {
      emit(
        HomeState(
          userResponse: data,
          userDataStatus: FormzStatus.submissionSuccess,
        ),
      );
    });


  }*/

}