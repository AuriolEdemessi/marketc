import 'dart:developer';

import 'package:marketscc/data/models/trx_model.dart';
import 'package:marketscc/infrastructure/network/exceptions/dio_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../export.dart';
import '../../../infrastructure/network/fedapay_client.dart';

@injectable
class HomeServices {
  BaseApiClient baseApiClient = BaseApiClient();
  FedapayClient fedapayClient = FedapayClient();

  Future<Either<ErrorMessage, List<AnnonceModel>>> getAnnonces() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "getrates?give_id=all&get_id=all&meilleur_taux=updated_at",);
      return Right(AnnonceResponse.fromJson(response.data['data']['data']).annonceList);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, TrxResponse>> fetchTransaction() async {

    try{
      Response response = await baseApiClient.get(pathUrl: "dashboard/states/",);

      TrxResponse.fromJson(response.data).data?.trx?.data?.forEach((element) {
        if((element.resteTimeout??0)<=0 && element.status=="0"){
          deleteTransaction(element.trxId!.toString());
        }
      });
      try {
        Response response = await baseApiClient.get(pathUrl: "dashboard/states/",);
        return Right(TrxResponse.fromJson(response.data));
      }on DioError catch (error) {
        return Left(DioException.fromDioError(error).errorMessage);
      }

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, DeleteTrxResponse>> deleteTransaction(String trxId) async {

    try{
      Response response = await baseApiClient.delete(pathUrl: "exchange/transaction", jsonBody: {"trx_id":'${trxId}'});

        return Right(DeleteTrxResponse.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  /*Future<Either<ErrorMessage, UserResponse>> getCurrentUser() async {
    try {
      Response response = await baseApiClient.get(pathUrl: "user/profile",);


      return Right(UserResponse.fromJson(response.data));
    } on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }*/
  Future<Either<ErrorMessage, FaqResponse>> getFaq() async {

    try{
      Response response = await baseApiClient.get(pathUrl: "faqs",);

      return Right(FaqResponse.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, AffiliationResponse>> getAffiliation() async {

    try{
      Response response = await baseApiClient.get(pathUrl: "user/affiliation",);

      return Right(AffiliationResponse.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, TestimonyResponse>> sendTemoignage(String temoignage) async {
    try {
      Response response = await baseApiClient.post(pathUrl: "dashboard/testimony", jsonBody: {"details":temoignage});

      return Right(TestimonyResponse.fromJson(response.data));
    } on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  Future<Either<ErrorMessage, List<CurrencyType>>> getListCurrencyType() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "currencies?groupByType=true",);
      return Right(CurrencyTypeResponse.fromJson(response.data['data']).currencyTypeList);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  Future<Either<ErrorMessage, List<CurrencyExchange>>> getListCurrencyExchange() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "currencies?groupByType=false",);
      return Right(CurrencyExchangeResponse.fromJson(response.data['data']).currencyExchangeList);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> createWallet(body) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "wallet", jsonBody: body);
      return Right(SucessMessage.fromJson(response.data['data']));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> deleteWalletById(id) async {
    try{
      Response response = await baseApiClient.delete(pathUrl: "wallet/$id");
      SucessMessage sucessMessage= SucessMessage.fromJson(response.data);
      return Right(sucessMessage);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> sellCoin(body) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "exchange/sell-coin", jsonBody: body);
      return Right(SucessMessage.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> updateAnnonce(body) async {
    try{
      Response response = await baseApiClient.put(pathUrl: "announcement/update", jsonBody: body);
      return Right(SucessMessage.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> deleteAnnonceById(id) async {
    try{
      Response response = await baseApiClient.delete(pathUrl: "announcement/delete/$id");
      return Right(SucessMessage.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, BuyCoinResponse>> buyCoin(body) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "exchange/buy-coin", jsonBody: body);
      return Right(BuyCoinResponse.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  Future<Either<ErrorMessage, List<TrxModel>>> salesList() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "exchange/history/sales");
      return Right(TrxList.fromJson(response.data['data']['data']).trxList);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, List<TrxModel>>> purchaseList() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "exchange/history/purchases");
      return Right(TrxList.fromJson(response.data['data']['data']).trxList);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> sendProof(body) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "exchange/transaction/upload", jsonBody: body);
      return Right(SucessMessage.fromJson(response.data));
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, BrandList>> brandImage() async {
    try{
      Response response = await baseApiClient.get(pathUrl: "dashboard/images");
      return Right(BrandList.fromJson(response.data));
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, TransactionApi>> getUrlTransaction(body) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "exchange/create_transaction_via_api", jsonBody: body);
      return Right(TransactionApiResponse.fromJson(response.data).data!);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, String>> getTransactionDetails(transactionId) async {
    try{
      Response response = await baseApiClient.get(pathUrl: "exchange/transaction_api/checking?id=$transactionId",);
      return Right(response.data["data"]["status"]);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  /// transaction
  ///
  ///


 /* Future<Either<ErrorMessage, FedaPayTransaction>> createTransaction(body, token) async {
    try{
      Response response = await fedapayClient.post(pathUrl: "transactions", token: token, jsonBody: body);
      return Right(FedaPayTransaction.fromJson(response.data["v1/transaction"]));
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, FedaPayTransaction>> getTransactionDetails(transactionId, token) async {
    try{
      Response response = await fedapayClient.get(pathUrl: "transactions/${transactionId}", token: token);
      return Right(FedaPayTransaction.fromJson(response.data["v1/transaction"]));
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, String>> getUrlTransaction(idTransaction, token) async {
    try{
      Response response = await fedapayClient.post(pathUrl: "transactions/$idTransaction/token", token: token, jsonBody: {});
      print("url==>${response.data["url"]}");
      return Right(response.data["url"]);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }*/

}
