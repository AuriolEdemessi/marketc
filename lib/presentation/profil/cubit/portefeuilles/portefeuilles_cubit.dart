import '../../../../export.dart';

class PortefeuillesCubit extends Cubit<PortefeuillesState> {
  final HomeScreenUseCase homeScreenUseCase;
  final AuthenticationUseCase authenticationUseCase;

  PortefeuillesCubit({required this.homeScreenUseCase, required this.authenticationUseCase}) : super(PortefeuillesState());

  Future<void> fetchCurrencyTypeList() async {
    emit(state.copyWith( currrencyTypeListStatus:FormzStatus.submissionInProgress));

    final result = await homeScreenUseCase.getListCurrencyType();

    result.fold((failure) {
      emit(state.copyWith(message: failure, currrencyTypeListStatus:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(currrencyTypeList: data, currrencyTypeListStatus:FormzStatus.submissionSuccess));
    });
  }


  Future<void> createWallet(body) async {
    emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.createWallet(body);
    result.fold((failure) {
      emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionFailure, message: failure));
    }, (data) async{
      final response = await authenticationUseCase.getUserData();
      response.fold((failure) {
        emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionFailure, message: failure));
      }, (data) {
        emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionSuccess, user: data.user));
      });
    });
  }

  Future<void> deleteWalletById(id) async {
    emit(PortefeuillesState(deteleWalletStatus:FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.deleteWalletById(id);
    result.fold((failure) {
      emit(PortefeuillesState(deteleWalletStatus:FormzStatus.submissionFailure, message: failure));
    }, (dataM) async{
      final response = await authenticationUseCase.getUserData();
      response.fold((failure) {
        emit(PortefeuillesState(deteleWalletStatus:FormzStatus.submissionFailure, message: failure));
      }, (data) {
        emit(PortefeuillesState(deteleWalletStatus:FormzStatus.submissionSuccess, user: data.user, updateMessage: dataM.message));
      });
    });
  }

  Future<void> reset() async {
    emit(PortefeuillesState(deteleWalletStatus:FormzStatus.pure, createWalletStatus:FormzStatus.pure));
  }

}