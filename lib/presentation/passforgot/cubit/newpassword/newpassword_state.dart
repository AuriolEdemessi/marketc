
import '../../../../export.dart';

class NewPasswordState extends BaseState {
  NewPasswordState({
    this.newPassword = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.message,
    this.dataresponse,
  });

  final Password newPassword;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final ErrorMessage? message;
  final DataResponse? dataresponse;

  @override
  List<Object?> get props => [
    newPassword,
    confirmedPassword,
    status,
    message,
    dataresponse,
  ];

  NewPasswordState copyWith({
    Password? newPassword,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    ErrorMessage? message,
    DataResponse? dataresponse,
  }) {
    return NewPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      message: message ?? this.message,
      dataresponse: dataresponse ?? this.dataresponse,
    );
  }
}