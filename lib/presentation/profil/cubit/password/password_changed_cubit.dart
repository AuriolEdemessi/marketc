import '../../../../export.dart';
import 'password_changed_state.dart';

class PasswordChangedCubit extends Cubit<PasswordChangedState> {
  final AuthenticationUseCase useCase;
  PasswordChangedCubit(this.useCase) : super(PasswordChangedState());

  void olderPasswordChanged(String value) {
    final nowPassword = Password.dirty(value);
    emit(state.copyWith(nowPassword: nowPassword, status: Formz.validate([state.newPassword,state.confirmedPassword, nowPassword])));
  }

  void newPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    emit(state.copyWith(newPassword: newPassword, status: Formz.validate([state.nowPassword,state.confirmedPassword, newPassword])));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(password: state.newPassword.value, value: value);
    emit(state.copyWith(confirmedPassword: confirmedPassword, status: Formz.validate([state.nowPassword,state.newPassword, confirmedPassword])));
  }

 Future<void> updatePassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      final result = await useCase.updatePassword(state.nowPassword.value, state.newPassword.value, state.confirmedPassword.value);

      result.fold((failure) {
        emit(
          state.copyWith(
            message: failure,
            status: FormzStatus.submissionFailure,
          ),
        );
      }, (token) {
        emit(
          state.copyWith(
            dataResponse: token,
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
