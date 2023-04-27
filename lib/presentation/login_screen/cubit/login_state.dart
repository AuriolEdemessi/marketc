
import '../../../export.dart';

class LoginState extends BaseState {
  LoginState({
    this.textFields = const TextFields.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.message,
  });

  final TextFields textFields;
  final Password password;
  final FormzStatus status;
  final ErrorMessage? message;
  final Email? email;

  @override
  List<Object?> get props => [
    textFields,
    password,
    email,
    status,
    message,
  ];

  LoginState copyWith({
    Password? password,
    TextFields? textFields,
    FormzStatus? status,
    Email? email,
    ErrorMessage? message,
  }) {
    return LoginState(
      textFields: textFields ?? this.textFields,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
    );
  }
}