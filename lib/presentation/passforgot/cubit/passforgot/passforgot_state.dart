
import '../../../../export.dart';

class PassForgotState extends BaseState {
  PassForgotState({
    this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.dataResponse,
    this.message,
  });

  final FormzStatus status;
  final ErrorMessage? message;
  final Email? email;
  final DataResponse? dataResponse;

  @override
  List<Object?> get props => [
    email,
    status,
    message,
    dataResponse,
    // token
  ];

  PassForgotState copyWith({
    Password? password,
    TextFields? textFields,
    FormzStatus? status,
    Email? email,
    ErrorMessage? message,
    DataResponse? dataResponse,
  }) {
    return PassForgotState(
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      dataResponse: dataResponse ?? this.dataResponse,
    );
  }
}