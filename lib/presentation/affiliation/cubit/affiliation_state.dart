import '../../../export.dart';

class AffiliationState extends BaseState {
  AffiliationState({
    this.affiliationStatus=FormzStatus.pure,
    this.data,
    this.message,
  });

  final ErrorMessage? message;
  final FormzStatus affiliationStatus;
  final AffiliationResponse? data;

  @override
  List<Object?> get props => [
    message,
    data,
    affiliationStatus,
  ];

  AffiliationState copyWith({
    ErrorMessage? message,
    FormzStatus? affiliationStatus,
    AffiliationResponse? data,
  }) {
    return AffiliationState(
      affiliationStatus: affiliationStatus ?? this.affiliationStatus,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}