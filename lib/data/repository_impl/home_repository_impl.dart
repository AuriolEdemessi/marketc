import 'package:marketscc/data/models/trx_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';

///Will be responsible to implement the home repository and having the functionality here

@Injectable(as: HomeScreenRepository)
class HomeScreenRepositoryImpl extends HomeScreenRepository {
  final HomeServices services;

  HomeScreenRepositoryImpl(this.services);

  @override
  Future<Either<ErrorMessage, List<AnnonceModel>>> getAnnonces() => services.getAnnonces();

  @override
  Future<Either<ErrorMessage, TrxResponse>> fetchTransaction() => services.fetchTransaction();

/*
  @override
  Future<Either<ErrorMessage, UserModel>> getCurrentUser() => services.getCurrentUser();
*/

  @override
  Future<Either<ErrorMessage, FaqResponse>> getFaq() => services.getFaq();

  @override
  Future<Either<ErrorMessage, AffiliationResponse>> getAffiliation() => services.getAffiliation();

  @override
  Future<Either<ErrorMessage, List<CurrencyType>>> getListCurrencyType() => services.getListCurrencyType();

  @override
  Future<Either<ErrorMessage, List<CurrencyExchange>>> getListCurrencyExchange() => services.getListCurrencyExchange();

  @override
  Future<Either<ErrorMessage, TestimonyResponse>> sendTemoignage(String temoignage) => services.sendTemoignage(temoignage);

  @override
  Future<Either<ErrorMessage, SucessMessage>> createWallet(body) => services.createWallet(body);

  @override
  Future<Either<ErrorMessage, SucessMessage>> sellCoin(body) => services.sellCoin(body);

  @override
  Future<Either<ErrorMessage, SucessMessage>> updateAnnonce(body) => services.updateAnnonce(body);

  @override
  Future<Either<ErrorMessage, SucessMessage>> deleteAnnonceById(id) => services.deleteAnnonceById(id);


  @override
  Future<Either<ErrorMessage, BuyCoinResponse>> buyCoin(body) => services.buyCoin(body);

  @override
  Future<Either<ErrorMessage, SucessMessage>> deleteWalletById(id) => services.deleteWalletById(id);

  @override
  Future<Either<ErrorMessage, List<TrxModel>>> purchaseList() => services.purchaseList();

  @override
  Future<Either<ErrorMessage, List<TrxModel>>> salesList() => services.salesList();

  @override
  Future<Either<ErrorMessage, SucessMessage>> sendProof(body) => services.sendProof(body);  @override

  @override
  Future<Either<ErrorMessage, BrandList>> brandImage() => services.brandImage();

  @override
  Future<Either<ErrorMessage, DeleteTrxResponse>> deleteTransaction(String trxId) => services.deleteTransaction(trxId);

/*
  @override
  Future<Either<ErrorMessage, FedaPayTransaction>> createTransaction(body, token) => services.createTransaction(body, token);
*/

  @override
  Future<Either<ErrorMessage, String>> getTransactionDetails(idTransaction) => services.getTransactionDetails(idTransaction);


  @override
  Future<Either<ErrorMessage, TransactionApi>> getUrlTransaction(body) => services.getUrlTransaction(body);

}
