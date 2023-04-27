
import '../../../../export.dart';

class PasswordChangedState extends BaseState {
  PasswordChangedState({
    this.nowPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.message,
    this.dataResponse,
  });

  final Password nowPassword;
  final Password newPassword;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final ErrorMessage? message;
  final String? dataResponse;

  @override
  List<Object?> get props => [
    nowPassword,
    newPassword,
    confirmedPassword,
    status,
    message,
    dataResponse,
  ];

  PasswordChangedState copyWith({
    Password? nowPassword,
    Password? newPassword,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    ErrorMessage? message,
    String? dataResponse,
  }) {
    return PasswordChangedState(
      nowPassword: nowPassword ?? this.nowPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      message: message ?? this.message,
      dataResponse: dataResponse ?? this.dataResponse,
    );
  }
}