import '../../../export.dart';

class MesAnnoncesState extends BaseState {
  MesAnnoncesState({
    this.mesAnnonceListStatus=FormzStatus.pure,
    this.message,
    this.sucessMessage,
  });

  final ErrorMessage? message;
  final SucessMessage? sucessMessage;
  final FormzStatus mesAnnonceListStatus;

  @override
  List<Object?> get props => [
    message,
    sucessMessage,
  ];

  MesAnnoncesState copyWith({
    ErrorMessage? message,
    SucessMessage? sucessMessage,
    FormzStatus? mesAnnonceListStatus,
  }) {
    return MesAnnoncesState(
      mesAnnonceListStatus: mesAnnonceListStatus ?? this.mesAnnonceListStatus,
      message: message ?? this.message,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}