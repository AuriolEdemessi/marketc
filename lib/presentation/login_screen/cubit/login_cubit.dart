
import '../../../export.dart';

class LoginCubit extends Cubit<LoginState> {
   final AuthenticationUseCase useCase;
  LoginCubit(this.useCase) : super(LoginState());

  void textFieldsChanged(String value) {
    final textFields = TextFields.dirty(value);
    emit(state.copyWith(textFields: textFields, status: Formz.validate([state.password, textFields])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password, status: Formz.validate([state.textFields, password])));
  }

  Future<void> logInWithCredentials({required bool isAndroid, required deviceData}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    late String devicename;
    try{
      if(isAndroid){
        devicename= "phone:${deviceData['manufacturer']}\tmodel:${deviceData['model']}\tversion:${deviceData['version.sdkInt']}\tdescription:${deviceData['display']}\tisPhysicalDevice:${deviceData['isPhysicalDevice']}";
      }else if(!isAndroid){
        devicename= "phone:${deviceData['name']}\tmodel:${deviceData['model']}\tversion:${deviceData['utsname.release']}\tdescription:${deviceData['identifierForVendor']}\tisPhysicalDevice:${deviceData['isPhysicalDevice']}";
      }else{
        devicename = "unknow";
      }

      final result = await useCase.repository.login(state.textFields.value, state.password.value, devicename, await hive.getOsUserID());
      result.fold((failure) {
        emit(
          state.copyWith(
            message: failure,
            status: FormzStatus.submissionFailure,
          ),
        );
      }, (token) {
        emit(
          LoginState(
            status: FormzStatus.submissionSuccess,

          ),
        );
      });


    }on Exception catch (e) {
      emit(
        state.copyWith(
          message: ErrorMessage(debug: '${e}', release: '${e}'),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }



   void emailChanged(String value) {
     final email = Email.dirty(value);
     emit(state.copyWith(email: email, status: Formz.validate([email])));
   }


   Future<void> init() async {
     emit(
       state.copyWith(
         status: FormzStatus.pure,
       ),
     );
   }

   Future<void> logout() async {
     emit(state.copyWith(status: FormzStatus.submissionInProgress));
     try{
       final result = await useCase.repository.logout();
       result.fold((failure) {
         emit(
           state.copyWith(
             message: failure,
             status: FormzStatus.submissionFailure,
           ),
         );
       }, (token) {

         emit(
           LoginState(
             status: FormzStatus.submissionSuccess,
           ),
         );
       });


     }on Exception catch (e) {
       emit(
         state.copyWith(
           message: ErrorMessage(debug: '${e}', release: '${e}'),
           status: FormzStatus.submissionFailure,
         ),
       );
     }

     //emit(state.copyWith(status: FormzStatus.submissionSuccess));
   }
}
