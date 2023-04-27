import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';

@injectable
class AuthenticationUseCase extends BaseUseCase<AuthenticationRepository> {
  AuthenticationUseCase(AuthenticationRepository repository) : super(repository);

  Future<Either<ErrorMessage, AuthState>> getAuthState() async => repository.getAuthState();
  Future<Either<ErrorMessage, String>> setupFirstLaunch() async => repository.setupFirstLaunch();
  Future<Either<ErrorMessage, TokenModel>> login(username, password, devicename, deviceId) async => repository.login(username, password, devicename, deviceId);
  Future<Either<ErrorMessage, String>> updatePassword(olderpassword, newpassword, confirmedpassword) async => repository.updatePassword(olderpassword, newpassword, confirmedpassword);
  Future<Either<ErrorMessage, DataResponse>> forgotCheckCode(code, email) async => repository.forgotCheckCode(code, email);
  Future<Either<ErrorMessage, DataResponse>> resetPassword(token, email) async => repository.resetPassword(token, email);
  Future<Either<ErrorMessage, UserResponse>> getUserData() async => repository.getUserData();
  Future<Either<ErrorMessage, UserResponse>> updateUser(body) async => repository.updateUser(body);
  Future<Either<ErrorMessage, SucessMessage>> deletedUser(body) async => repository.deletedUser(body);
  Future<Either<ErrorMessage, UserResponse>> putDeviceId({required String deviceId, required String version}) async => repository.putDeviceId(deviceId:deviceId, version: version);
  Future<Either<ErrorMessage, UserResponse>> kycVerify(body) async => repository.kycVerify(body);
  Future<Either<ErrorMessage, UserResponse>> verifyRevendeur(body) async => repository.verifyRevendeur(body);
  Future<Either<ErrorMessage, UserResponse>> uploadImageProfile(body) async => repository.uploadImageProfile(body);
  Future<Either<ErrorMessage, TokenModel>> register(fname, lname, username, email, password, phone, devicename, country, deviceId, referBy) async => repository.register(fname, lname, username, email, password, phone, devicename, country, deviceId, referBy);
}
