import 'package:dartz/dartz.dart';

import '../../export.dart';

abstract class AuthenticationRepository extends BaseRepository {
  Future<Either<ErrorMessage, AuthState>> getAuthState();
  Future<Either<ErrorMessage, String>> setupFirstLaunch();
  Future<Either<ErrorMessage, TokenModel>> login(username, password, devicename, deviceId);
  Future<Either<ErrorMessage, DataResponse>> sendRequestCode(email);
  Future<Either<ErrorMessage, DataResponse>> forgotCheckCode(code, email);
  Future<Either<ErrorMessage, DataResponse>> resetPassword(token, password);
  Future<Either<ErrorMessage, UserResponse>> getUserData();
  Future<Either<ErrorMessage, UserResponse>> updateUser(body);
  Future<Either<ErrorMessage, UserResponse>> putDeviceId({required String deviceId, required String version});
  Future<Either<ErrorMessage, SucessMessage>> deletedUser(body);
  Future<Either<ErrorMessage, UserResponse>> kycVerify(body);
  Future<Either<ErrorMessage, UserResponse>> verifyRevendeur(body);
  Future<Either<ErrorMessage, UserResponse>> uploadImageProfile(body);
  Future<Either<ErrorMessage, TokenModel>> register(fname, lname, username, email, password, phone, devicename, country, deviceId, referBy);
  Future<Either<ErrorMessage, TokenModel>> logout();
  Future<Either<ErrorMessage, String>> updatePassword(olderpassword, newpassword, confirmedpassword);
}
