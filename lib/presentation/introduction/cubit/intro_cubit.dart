import '../../../export.dart';

class IntroCubit extends Cubit<IntroState> {
  final AuthenticationUseCase useCase;
  IntroCubit(this.useCase) : super(IntroState());

  Future<void> setupFirstLaunch() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      final result = await useCase.repository.setupFirstLaunch();
      result.fold((failure) {
        emit(
          state.copyWith(
            message: failure,
            status: FormzStatus.submissionFailure,
          ),
        );
      }, (response) {
        emit(
          IntroState(
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

}