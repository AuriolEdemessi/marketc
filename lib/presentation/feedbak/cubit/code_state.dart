
import '../../../export.dart';

class CodeState extends BaseState {
  CodeState({
    this.status = FormzStatus.pure,
    this.code,
    this.message,
  });

  final FormzStatus status;
  final ErrorMessage? message;
  final String? code;

  @override
  List<Object?> get props => [
    code,
    status,
    message,
    // token
  ];

  CodeState copyWith({
    FormzStatus? status,
    ErrorMessage? message,
    String? code,
  }) {
    return CodeState(
      status: status ?? this.status,
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}