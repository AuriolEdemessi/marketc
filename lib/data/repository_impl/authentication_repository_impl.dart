import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationServices authenticationServices;

  AuthenticationRepositoryImpl(this.authenticationServices);

  @override
  Future<Either<ErrorMessage, AuthState>> getAuthState() => authenticationServices.getAuthState();

  @override
  Future<Either<ErrorMessage, String>> setupFirstLaunch() => authenticationServices.setupFirstLaunch();

  @override
  Future<Either<ErrorMessage, TokenModel>> login(username, password, devicename, deviceId) => authenticationServices.login(username, password, devicename, deviceId);

  @override
  Future<Either<ErrorMessage, TokenModel>> register(fname, lname, username, email, password, phone, devicename, country, deviceId, referBy) => authenticationServices.register(fname, lname, username, email, password, phone, devicename, country, deviceId, referBy);

  @override
  Future<Either<ErrorMessage, DataResponse>> sendRequestCode(email) => authenticationServices.sendRequestCode(email);

  @override
  Future<Either<ErrorMessage, DataResponse>> forgotCheckCode(code, email) => authenticationServices.forgotCheckCode(code, email);

  @override
  Future<Either<ErrorMessage, DataResponse>> resetPassword(token, password) => authenticationServices.resetPassword(token, password);


  @override
  Future<Either<ErrorMessage, String>> updatePassword(olderpassword, newpassword, confirmedpassword) => authenticationServices.updatePassword(olderpassword, newpassword, confirmedpassword);


  @override
  Future<Either<ErrorMessage, UserResponse>> getUserData() => authenticationServices.getUserData();

  @override
  Future<Either<ErrorMessage, UserResponse>> updateUser(body) => authenticationServices.updateUser(body);

  @override
  Future<Either<ErrorMessage, UserResponse>> putDeviceId({required String deviceId, required String version}) => authenticationServices.putDeviceId(deviceId: deviceId, version: version);


  @override
  Future<Either<ErrorMessage, SucessMessage>> deletedUser(body) => authenticationServices.deletedUser(body);

  @override
  Future<Either<ErrorMessage, UserResponse>> kycVerify(body) => authenticationServices.kycVerify(body);

  @override
  Future<Either<ErrorMessage, UserResponse>> verifyRevendeur(body) => authenticationServices.verifyRevendeur(body);

  @override
  Future<Either<ErrorMessage, TokenModel>> logout() => authenticationServices.logout();

  @override
  Future<Either<ErrorMessage, UserResponse>> uploadImageProfile(body) => authenticationServices.uploadImageProfile(body);

}
