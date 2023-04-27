import '../../../../export.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final AuthenticationUseCase useCase;
  NewPasswordCubit(this.useCase) : super(NewPasswordState());


  void newPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    emit(state.copyWith(newPassword: newPassword, status: Formz.validate([state.confirmedPassword, newPassword])));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(password: state.newPassword.value, value: value);
    emit(state.copyWith(confirmedPassword: confirmedPassword, status: Formz.validate([state.newPassword, confirmedPassword])));
  }

  Future<void> resetPassword(token) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      final result = await useCase.resetPassword(token, state.confirmedPassword.value);

      result.fold((failure) {
        emit(
          state.copyWith(
            message: failure,
            status: FormzStatus.submissionFailure,
          ),
        );
      }, (data) {
        emit(
          state.copyWith(
            dataresponse: data,
            status: FormzStatus.submissionSuccess,
          ),
        );
      });

    }on Exception catch (e) {
      emit(
        state.copyWith(
          message: ErrorMessage(debug: '${e}', release: '${e}'),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }



}
