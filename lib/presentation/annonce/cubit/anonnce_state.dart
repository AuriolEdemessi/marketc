import '../../../export.dart';

class AnnonceState extends BaseState {
  AnnonceState({
    this.deviseListStatus=FormzStatus.pure,
    this.annonceListStatus=FormzStatus.pure,
    this.sellCoinStatus=FormzStatus.pure,
    this.updateAnnonceStatus=FormzStatus.pure,
    this.deleteAnnonceStatus=FormzStatus.pure,
    this.deviseList,
    this.annoncesList,
    this.message,
    this.sucessMessage,
  });

  final ErrorMessage? message;
  final SucessMessage? sucessMessage;
  final FormzStatus deviseListStatus;
  final FormzStatus annonceListStatus;
  final FormzStatus sellCoinStatus;
  final FormzStatus updateAnnonceStatus;
  final FormzStatus deleteAnnonceStatus;
  final List<CurrencyExchange>? deviseList;
  final List<AnnonceModel>? annoncesList;

  @override
  List<Object?> get props => [
    message,
    sucessMessage,
    deviseList,
    annoncesList,
    deviseListStatus,
    sellCoinStatus,
    updateAnnonceStatus,
    annonceListStatus,
    deleteAnnonceStatus,
  ];

  AnnonceState copyWith({
    ErrorMessage? message,
    SucessMessage? sucessMessage,
    FormzStatus? deviseListStatus,
    FormzStatus? updateAnnonceStatus,
    FormzStatus? sellCoinStatus,
    FormzStatus? annonceListStatus,
    FormzStatus? deleteAnnonceStatus,
    List<CurrencyExchange>? deviseList,
    List<AnnonceModel>? annoncesList,
  }) {
    return AnnonceState(
      deviseList: deviseList ?? this.deviseList,
      updateAnnonceStatus: updateAnnonceStatus ?? this.updateAnnonceStatus,
      annoncesList: annoncesList ?? this.annoncesList,
      annonceListStatus: annonceListStatus ?? this.annonceListStatus,
      deleteAnnonceStatus: deleteAnnonceStatus ?? this.deleteAnnonceStatus,
      deviseListStatus: deviseListStatus ?? this.deviseListStatus,
      sellCoinStatus: sellCoinStatus ?? this.sellCoinStatus,
      message: message ?? this.message,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}