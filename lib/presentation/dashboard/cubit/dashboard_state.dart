
import '../../../export.dart';

class DashboardState extends BaseState {
  DashboardState({
    this.status = FormzStatus.pure,
    this.message,
  });

  final FormzStatus status;
  final ErrorMessage? message;

  @override
  List<Object?> get props => [
    status,
    message,
   // token
  ];

  DashboardState copyWith({
    FormzStatus? status,
    ErrorMessage? message,
  }) {
    return DashboardState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}