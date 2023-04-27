import '../../../export.dart';

class ExchangeState extends BaseState {
  ExchangeState({
    this.exchangeListStatus=FormzStatus.pure,
    this.buyCoinStatus=FormzStatus.pure,
    this.sendProofStatus=FormzStatus.pure,
    this.exchangeList,
    this.message,
    this.sucessMessage,
    this.buyCoinResponse,
  });

  final ErrorMessage? message;
  final SucessMessage? sucessMessage;
  final FormzStatus exchangeListStatus;
  final FormzStatus buyCoinStatus;
  final FormzStatus sendProofStatus;
  final BuyCoinResponse? buyCoinResponse;
  final List<CurrencyExchange>? exchangeList;

  @override
  List<Object?> get props => [
    message,
    sucessMessage,
    exchangeList,
    exchangeListStatus,
    buyCoinStatus,
    sendProofStatus,
    buyCoinResponse,
  ];

  ExchangeState copyWith({
    ErrorMessage? message,
    SucessMessage? sucessMessage,
    BuyCoinResponse? buyCoinResponse,
    FormzStatus? exchangeListStatus,
    FormzStatus? buyCoinStatus,
    FormzStatus? sendProofStatus,
    List<CurrencyExchange>? exchangeList,
  }) {
    return ExchangeState(
      exchangeListStatus: exchangeListStatus ?? this.exchangeListStatus,
      buyCoinStatus: buyCoinStatus ?? this.buyCoinStatus,
      sendProofStatus: sendProofStatus ?? this.sendProofStatus,
      exchangeList: exchangeList ?? this.exchangeList,
      message: message ?? this.message,
      buyCoinResponse: buyCoinResponse ?? this.buyCoinResponse,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}