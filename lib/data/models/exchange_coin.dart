import '../../export.dart';

class ExchangeBuyCoin{
  final String? trId;
  final String? text;
  final String? quantityToExchange;
  final AnnonceModel? annonceModel;
  final WalletUser? walletUser;

  ExchangeBuyCoin({this.trId, this.quantityToExchange, this.annonceModel, this.walletUser, this.text});
}