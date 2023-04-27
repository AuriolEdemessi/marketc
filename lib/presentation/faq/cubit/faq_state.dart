import '../../../export.dart';

class FaqState extends BaseState {
  FaqState({
    this.faqStatus=FormzStatus.pure,
    this.faqList,
    this.message,
  });

  final ErrorMessage? message;
  final FormzStatus faqStatus;
  final List<FaqModel>? faqList;

  @override
  List<Object?> get props => [
    message,
    faqList,
    faqStatus,
  ];

  FaqState copyWith({
    ErrorMessage? message,
    FormzStatus? faqStatus,
    List<FaqModel>? faqList,
  }) {
    return FaqState(
      faqStatus: faqStatus ?? this.faqStatus,
      faqList: faqList ?? this.faqList,
      message: message ?? this.message,
    );
  }
}