
import '../../../export.dart';

class FeedbakState extends BaseState {
  FeedbakState({
    this.temoignage = const TextFields.pure(),
    this.status = FormzStatus.pure,
    this.message,
    this.testimonyResponse,
  });

  final TextFields temoignage;
  final FormzStatus status;
  final ErrorMessage? message;
  final TestimonyResponse? testimonyResponse;

  @override
  List<Object?> get props => [
    temoignage,
    testimonyResponse,
    status,
    message,
    // token
  ];

  FeedbakState copyWith({
    TextFields? temoignage,
    FormzStatus? status,
    ErrorMessage? message,
    TestimonyResponse? testimonyResponse,
  }) {
    return FeedbakState(
      temoignage: temoignage ?? this.temoignage,
      status: status ?? this.status,
      message: message ?? this.message,
      testimonyResponse: testimonyResponse ?? this.testimonyResponse,
    );
  }
}