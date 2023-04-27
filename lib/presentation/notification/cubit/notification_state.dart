import '../../../export.dart';

class NotificationState extends BaseState {
  NotificationState({
    this.message,
    this.sucessMessage,
  });

  final ErrorMessage? message;
  final SucessMessage? sucessMessage;

  @override
  List<Object?> get props => [
    message,
    sucessMessage,
  ];

  NotificationState copyWith({
    ErrorMessage? message,
    SucessMessage? sucessMessage,
  }) {
    return NotificationState(
      message: message ?? this.message,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}