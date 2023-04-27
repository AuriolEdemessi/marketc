import 'package:marketscc/data/models/trx_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';


@injectable
class HomeScreenUseCase extends BaseUseCase<HomeScreenRepository> {
  HomeScreenUseCase(HomeScreenRepository repository) : super(repository);

  Future<Either<ErrorMessage, List<AnnonceModel>>> getAnnonces() async => repository.getAnnonces();
  Future<Either<ErrorMessage, TrxResponse>> fetchTransaction() async => repository.fetchTransaction();
 // Future<Either<ErrorMessage, UserModel>> getCurrentUser() async => repository.getCurrentUser();
  Future<Either<ErrorMessage, FaqResponse>> getFaq() async => repository.getFaq();
  Future<Either<ErrorMessage, AffiliationResponse>> getAffiliation() async => repository.getAffiliation();
  Future<Either<ErrorMessage, List<CurrencyType>>> getListCurrencyType() async => repository.getListCurrencyType();
  Future<Either<ErrorMessage, List<CurrencyExchange>>> getListCurrencyExchange() async => repository.getListCurrencyExchange();
  Future<Either<ErrorMessage, TestimonyResponse>> sendTemoignage(String code, String temoignage) async => repository.sendTemoignage(temoignage);
  Future<Either<ErrorMessage, SucessMessage>> createWallet(body) async => repository.createWallet(body);
  Future<Either<ErrorMessage, SucessMessage>> deleteWalletById(id) async => repository.deleteWalletById(id);

  Future<Either<ErrorMessage, SucessMessage>> sellCoin(body) async => repository.sellCoin(body);
  Future<Either<ErrorMessage, SucessMessage>> updateAnnonce(body) async => repository.updateAnnonce(body);
  Future<Either<ErrorMessage, BuyCoinResponse>> buyCoin(body) async => repository.buyCoin(body);
  Future<Either<ErrorMessage, SucessMessage>> deleteAnnonceById(id) async => repository.deleteAnnonceById(id);


  Future<Either<ErrorMessage, List<TrxModel>>> getListPurchase() async => repository.purchaseList();
  Future<Either<ErrorMessage, List<TrxModel>>> getListSales() async => repository.salesList();
  Future<Either<ErrorMessage, SucessMessage>> sendProof(body) async => repository.sendProof(body);
  Future<Either<ErrorMessage, BrandList>> brandImage() async => repository.brandImage();
  Future<Either<ErrorMessage, DeleteTrxResponse>> deleteTransaction(String trxId) async => repository.deleteTransaction(trxId);

  //Future<Either<ErrorMessage, FedaPayTransaction>> createTransaction(body, token) async => repository.createTransaction(body, token);
  Future<Either<ErrorMessage, String>> getTransactionDetails(idTransaction) async => repository.getTransactionDetails(idTransaction);
  Future<Either<ErrorMessage, TransactionApi>> getUrlTransaction(body) async => repository.getUrlTransaction(body);

}
