import '../../../../export.dart';

class PassForgotCubit extends Cubit<PassForgotState> {
  final AuthenticationUseCase useCase;
   PassForgotCubit(this.useCase) : super(PassForgotState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }


  Future<void> sendRequestChangeCode() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{

      final result = await useCase.repository.sendRequestCode(state.email!.value);
      result.fold((failure) {
        emit(state.copyWith(message: failure, status: FormzStatus.submissionFailure));
      }, (data) {
        emit(state.copyWith(dataResponse: data, status: FormzStatus.submissionSuccess));
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

  Future<void> sendCode(String code) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{

      final result = await useCase.repository.sendRequestCode(state.email!.value);
      result.fold((failure) {
        emit(state.copyWith(message: failure, status: FormzStatus.submissionFailure));
      }, (data) {
        emit(state.copyWith(dataResponse: data, status: FormzStatus.submissionSuccess));
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

  Future<void> init() async {
    emit(
      state.copyWith(
        status: FormzStatus.pure,
      ),
    );
  }

   String? get getemail {
    return  state.email?.value;
  }

}
