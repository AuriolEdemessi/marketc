import '../../../export.dart';

class IntroState extends BaseState {
  IntroState({
    this.status = FormzStatus.pure,
    this.message,
  });

  final FormzStatus status;
  final ErrorMessage? message;
  @override
  List<Object?> get props => [
    status,
    message,
  ];

  IntroState copyWith({
    FormzStatus? status,
    ErrorMessage? message,
  }) {
    return IntroState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}