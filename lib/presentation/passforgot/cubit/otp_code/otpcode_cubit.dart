import 'package:marketscc/export.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthenticationUseCase useCase;
  OtpCubit(this.useCase) : super(OtpState());

  Future<void> forgotCheck(email) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await useCase.forgotCheckCode(state.otpTextFields.value, email);
    result.fold((failure) {
      emit(state.copyWith(message: failure, status: FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(data:data, status: FormzStatus.submissionSuccess));
    });
  }

  void otpTextFieldsChanged(String value) {
    final textFields = OtpText.dirty(value);
    emit(state.copyWith(otpTextFields: textFields, status: Formz.validate([textFields])));
  }

}
