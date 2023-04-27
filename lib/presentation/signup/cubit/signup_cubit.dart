import 'dart:developer';

import '../../../export.dart';

class SignupCubit extends Cubit<SignupState> {
   final AuthenticationUseCase useCase;
  SignupCubit(this.useCase) : super(SignupState());

  void lastNameChanged(String value) {
    final lastname = TextFields.dirty(value);
    emit(state.copyWith(lastname: lastname, status: Formz.validate([lastname, state.firstname, state.email, state.phonenumber, state.password])));
  }

  void firstNameChanged(String value) {
    final firstname = TextFields.dirty(value);
    emit(state.copyWith(firstname: firstname, status: Formz.validate([firstname, state.lastname, state.phonenumber, state.email, state.password])));
  }

   void pseudoChanged(String value) {
     final pseudo = Pseudo.dirty(value);
     emit(state.copyWith(pseudo: pseudo, status: Formz.validate([pseudo, state.firstname, state.lastname, state.phonenumber, state.email, state.password])));
   }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email, state.lastname, state.phonenumber, state.firstname, state.password])));
  }

  void phoneNumberChanged(String value, CountryCode? countryCode) {
    final phonenumber = TextFields.dirty(value);
    emit(state.copyWith(phonenumber: phonenumber, countryCode: countryCode??CountryCode(name: "Bénin", code: "BJ", dialCode: "+229"), status: Formz.validate([phonenumber, state.lastname, state.email, state.firstname, state.password])));
  }

  void countryCodeChanged(CountryCode countryCode) {
    emit(state.copyWith(countryCode: countryCode, status: Formz.validate([state.lastname, state.email, state.firstname, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password, status: Formz.validate([password, state.lastname, state.email, state.firstname, state.phonenumber])));
  }

  Future<void> signupUser({required bool isAndroid, required deviceData, referBy}) async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
     late String devicename;
      if(isAndroid){
        devicename= "phone:${deviceData['manufacturer']}\tmodel:${deviceData['model']}\tversion:${deviceData['version.sdkInt']}\tdescription:${deviceData['display']}\tisPhysicalDevice:${deviceData['isPhysicalDevice']}";
      }else if(!isAndroid){
        devicename= "phone:${deviceData['name']}\tmodel:${deviceData['model']}\tversion:${deviceData['utsname.release']}\tdescription:${deviceData['identifierForVendor']}\tisPhysicalDevice:${deviceData['isPhysicalDevice']}";
      }else{
        devicename = "unknow";
      }

      log("countryCode==>${state.countryCode.toString()}");

    log("${
        state.firstname.value +"\n"+
            state.lastname.value +"\n"+
            state.pseudo.value +"\n"+
            state.email.value +"\n"+
            state.password.value +"\n"+
            state.phonenumber.value +"\n"+
            devicename +"\n"+
            state.countryCode.toString() +"\n"+
            await hive.getOsUserID().toString() +"\n"+
            referBy
    }");

      final result = await useCase.repository.register(state.firstname.value, state.lastname.value, state.pseudo.value,state.email.value, state.password.value, state.phonenumber.value, devicename, state.countryCode, await hive.getOsUserID(), referBy);
      result.fold((failure) {
        emit(
          state.copyWith(
            message: failure,
            status: FormzStatus.submissionFailure,
          ),
        );
      }, (token) {
        emit(
          SignupState(
            status: FormzStatus.submissionSuccess,
          ),
        );
      });




  }
}
