
import 'package:dartz/dartz.dart';

import '../../data/models/trx_model.dart';
import '../../export.dart';

abstract class HomeScreenRepository extends BaseRepository {
  Future<Either<ErrorMessage, List<AnnonceModel>>> getAnnonces();
  Future<Either<ErrorMessage, TrxResponse>> fetchTransaction();
  Future<Either<ErrorMessage, FaqResponse>> getFaq();
  Future<Either<ErrorMessage, AffiliationResponse>> getAffiliation();

  Future<Either<ErrorMessage, List<CurrencyType>>> getListCurrencyType();
  Future<Either<ErrorMessage, List<CurrencyExchange>>> getListCurrencyExchange();

  Future<Either<ErrorMessage, TestimonyResponse>> sendTemoignage(String temoignage);

  Future<Either<ErrorMessage, SucessMessage>> createWallet(body);
  Future<Either<ErrorMessage, SucessMessage>> deleteWalletById(id);

  Future<Either<ErrorMessage, SucessMessage>> sellCoin(body);
  Future<Either<ErrorMessage, SucessMessage>> updateAnnonce(body);
  Future<Either<ErrorMessage, BuyCoinResponse>> buyCoin(body);
  Future<Either<ErrorMessage, SucessMessage>> deleteAnnonceById(id);

  Future<Either<ErrorMessage, List<TrxModel>>> purchaseList();
  Future<Either<ErrorMessage, List<TrxModel>>> salesList();

  Future<Either<ErrorMessage, SucessMessage>> sendProof(body);

  Future<Either<ErrorMessage, BrandList>> brandImage();


  Future<Either<ErrorMessage, DeleteTrxResponse>> deleteTransaction(String trxId);

  //Future<Either<ErrorMessage, FedaPayTransaction>> createTransaction(body, token);
  Future<Either<ErrorMessage, TransactionApi>> getUrlTransaction(body);
  Future<Either<ErrorMessage, String>> getTransactionDetails(idTransaction);

}
