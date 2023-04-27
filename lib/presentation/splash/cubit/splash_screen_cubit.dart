import '../../../export.dart';

///Home Cubit that will have the repo and all the requests
class SplashScreenCubit extends BaseCubit {
  SplashScreenCubit(this.useCase) : super(InitialState());

  final AuthenticationUseCase useCase;

  Future<void> getAuthState() async {
    emit(LoadingState());
    final result = await useCase.getAuthState();
    result.fold(
          (failure) {
            emit(FailureState(failure));
      },
          (data) {
            emit(SuccessState(data));
      },
    );

   /* if (response.success) {
      emit(SuccessState<AuthState>(response.data!));
    } else {
      emit(FailureState(response.error));
    }*/
  }
}