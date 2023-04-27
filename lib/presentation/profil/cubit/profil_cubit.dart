import 'dart:async';

import 'package:marketscc/data/models/user_model.dart';

import '../../../export.dart';

class ProfilCubit extends Cubit<ProfilState> {
  final AuthenticationUseCase useCase;
  ProfilCubit(this.useCase) : super(ProfilState());

  UserModel? userModel = UserModel();
  UserModel? get getUser => userModel;

  Future<void> fetchUser() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final result = await useCase.getUserData();
    result.fold((failure) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, message: failure));
    }, (data) {

      userModel = data.user!;
      emit(state.copyWith(status: FormzStatus.submissionSuccess, userResponse: data,));
    });
  }

  Future<void> updateUser({data}) async {
    emit(state.copyWith(updateStatus: FormzStatus.submissionInProgress));

    final result = await useCase.updateUser(data);
    result.fold((failure) {
      emit(state.copyWith(updateStatus: FormzStatus.submissionFailure, message: failure));
    }, (data) {
      userModel = data.user!;
      emit(state.copyWith(updateStatus: FormzStatus.submissionSuccess, userResponse: data,));
    });
  }

  Future<void> deletedUser({data}) async {
    Map<String, dynamic> body ={
      "password":data
    };
    emit(state.copyWith(deleteStatus: FormzStatus.submissionInProgress));

    final result = await useCase.deletedUser(body);
    result.fold((failure) {
      emit(state.copyWith(deleteStatus: FormzStatus.submissionFailure, message: failure));
    }, (data) {
      emit(state.copyWith(deleteStatus: FormzStatus.submissionSuccess, sucessMessage: data,));
    });
  }

  Future<void> putDeviceId({deviceId, version }) async {
    emit(state.copyWith(putDevice: FormzStatus.submissionInProgress));

    final result = await useCase.putDeviceId(deviceId: deviceId, version: version);
    result.fold((failure) {
      //emit(state.copyWith(updateStatus: FormzStatus.submissionFailure, message: failure));
    }, (data) {
      emit(state.copyWith(putDevice: FormzStatus.submissionSuccess, userResponse: data,));
    });
  }

  Future<void> kycVerify({data}) async {

    emit(state.copyWith(kycVerifyStatus: FormzStatus.submissionInProgress));

    final result = await useCase.kycVerify(data);

    result.fold((failure) {
      emit(state.copyWith(kycVerifyStatus: FormzStatus.submissionFailure, message: failure));
    }, (response) {
      userModel = response.user!;
      emit(state.copyWith(kycVerifyStatus: FormzStatus.submissionSuccess, userResponse: response,));
    });
  }

  Future<void> verifyRevendeur({data}) async {

    emit(state.copyWith(revendeurVerifyStatus: FormzStatus.submissionInProgress));

    final result = await useCase.verifyRevendeur(data);

    result.fold((failure) {
      emit(state.copyWith(revendeurVerifyStatus: FormzStatus.submissionFailure, message: failure));
    }, (response) {
      userModel = response.user!;
      emit(state.copyWith(revendeurVerifyStatus: FormzStatus.submissionSuccess, userResponse: response,));
    });
  }

  Future<void> uploadImageProfile({data}) async {

    emit(state.copyWith(uploaImage: FormzStatus.submissionInProgress));

    final result = await useCase.uploadImageProfile(data);

    result.fold((failure) {
      emit(state.copyWith(uploaImage: FormzStatus.submissionFailure, message: failure));
    }, (data) {
      userModel = data.user!;
      emit(state.copyWith(uploaImage: FormzStatus.submissionSuccess, userResponse: data,));
    });
  }

  setUserData(UserModel? user){
    userModel = user;
  }

}