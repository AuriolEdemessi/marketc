import 'dart:developer';
import 'dart:io';

import 'package:marketscc/infrastructure/network/exceptions/dio_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../export.dart';

@injectable
class AuthenticationServices {

  BaseApiClient baseApiClient = BaseApiClient();

  Future<Either<ErrorMessage, AuthState>> getAuthState() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      String? resultat = await hive.getToken();
      bool isFirst = await hive.getIsFirst();
      if(resultat==null){
        if(!isFirst){
          return const Right(AuthState.unknown);
        }else{
          return const Right(AuthState.unauthenticated);
        }
      }else{
        return const Right(AuthState.authenticated);
      }
    } catch (error){
      return Left(ErrorMessage(debug: "error", release: "error"));
    }

  }

  Future<Either<ErrorMessage, TokenModel>> login(username, password, devicename, deviceId) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "login", jsonBody:{"username":username, "password":password, "device_name":devicename, "device_id":deviceId});

        TokenModel tokenModel= TokenModel.fromJson(response.data);
        hive.saveToken(tokenModel.token!);
        hive.saveIsFirst(true);
        return Right(tokenModel);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, String>> updatePassword(olderpassword, newpassword, confirmedpassword) async {

    try{
      Response res = await baseApiClient.put(pathUrl: "user/password", jsonBody:{"current_password":olderpassword, "new_password":newpassword, "new_password_confirmation":confirmedpassword});


      if(DataResponse.fromJson(res.data).success??false){
        try{
          Response response = await baseApiClient.post(pathUrl: "logout");

          if(TokenModel.fromJson(response.data).success??false){
            hive.deleteToken();
            return Right("${DataResponse.fromJson(res.data).message}");
          }else{
            return Right("Une erreur s'est produite, veuillez réessayer");
          }
        }on DioError catch (error) {
          return Left(DioException.fromDioError(error).errorMessage);
        }

      }else{
        return Right("Une erreur s'est produite, veuillez réessayer");
      }

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, DataResponse>> sendRequestCode(email) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "user-password/forgot", jsonBody:{"email":email,});

        DataResponse errorResponse= DataResponse.fromJson(response.data);
        return Right(errorResponse);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
    }

  Future<Either<ErrorMessage, DataResponse>> forgotCheckCode(code,email) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "user-password/forgot-check", jsonBody:{"code":code,"email":email,});

      DataResponse dataResponse= DataResponse.fromJson(response.data);
      if(dataResponse.success!){
        return Right(dataResponse);
      }else{
        return Left(ErrorMessage(debug: "${dataResponse.message}", release: "${dataResponse.message}"));
      }

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, DataResponse>> resetPassword(token,password) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "user-password/reset", jsonBody:{"token":token,"password":password,});

        DataResponse dataResponse= DataResponse.fromJson(response.data);
        return Right(dataResponse);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  Future<Either<ErrorMessage, TokenModel>> register(fname, lname, username, email, password, phone, devicename, CountryCode country, deviceId, referBy) async {
    try{
      Response response = await baseApiClient.post(pathUrl: "register",
          jsonBody:
          {
            "fname":fname,
            "lname":lname,
            "username":username,
            "email":email,
            "phone":phone,
            "password":password,
            "device_name":devicename,
            "country":country.code,
            "phone_indicatif":country.dialCode,
            "device_id":deviceId,
            "referBy":referBy,
          });


        TokenModel tokenModel= TokenModel.fromJson(response.data);
        hive.saveToken(tokenModel.token!);
        hive.saveIsFirst(true);
        return Right(tokenModel);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, UserResponse>> getUserData() async {

    try{

        Response response = await baseApiClient.get(pathUrl: "user/profile/");
        return Right(UserResponse.fromJson(response.data));

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }

  }

  Future<Either<ErrorMessage, UserResponse>> updateUser(body) async {

    try{
      Response response = await baseApiClient.put(pathUrl: "user/profile", jsonBody: body);

        UserResponse usermodel= UserResponse.fromJson(response.data);
        return Right(usermodel);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, SucessMessage>> deletedUser(body) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "user/delete", jsonBody: body);

      SucessMessage res= SucessMessage.fromJson(response.data);
      hive.deleteToken();
        return Right(res);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, UserResponse>> putDeviceId({required String deviceId, required String version}) async {

    try{
      Response response = await baseApiClient.put(pathUrl: "notification/device_id", jsonBody: {
        "device_id":deviceId,
        "version":version,
      });

        UserResponse usermodel= UserResponse.fromJson(response.data);
        return Right(usermodel);

    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, UserResponse>> kycVerify(body) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "kyc/verification", jsonBody: body);
        return Right(UserResponse.fromJson(response.data));

    }on DioError catch (error) {
       return Left(DioException.fromDioError(error).errorMessage);    
    }
  }
  Future<Either<ErrorMessage, UserResponse>> verifyRevendeur(body) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "kyc/verification-revendeur", jsonBody: body);
        return Right(UserResponse.fromJson(response.data));

    }on DioError catch (error) {
       return Left(DioException.fromDioError(error).errorMessage);
    }
  }

  Future<Either<ErrorMessage, UserResponse>> uploadImageProfile(body) async {

    try{
      Response response = await baseApiClient.post(pathUrl: "user/profile/image", jsonBody: body);

        UserResponse usermodel = UserResponse.fromJson(response.data);

        return Right(usermodel);

    }on DioError catch (error) {
       return Left(DioException.fromDioError(error).errorMessage);
    }
  }


  Future<Either<ErrorMessage, String>> setupFirstLaunch() async {
    try{
      hive.saveIsFirst(true);
      return Right("Sucess");
    }catch (e){
      return Left(ErrorMessage());
    }
  }

  Future<Either<ErrorMessage, TokenModel>> logout() async {

    try{
      Response response = await baseApiClient.post(pathUrl: "logout");
        TokenModel tokenModel= TokenModel.fromJson(response.data);
        hive.deleteToken();
        return Right(tokenModel);
    }on DioError catch (error) {
      return Left(DioException.fromDioError(error).errorMessage);
    }
  }

    /*  try {
      String? resultat = await LocalStorage.secureRead(appStateKey);
      log("runtimeType==>${resultat.runtimeType}");
      if(resultat ==null){
        return const Right(AuthState.unknown);
      }else if(resultat ==AuthState.authenticated.name){
        return const Right(AuthState.authenticated);
      }else{
        return const Right(AuthState.unauthenticated);
      }
    } on ServerException {
      return const Left(Failure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }*/
  }

