import '../../../export.dart';

class FeebakCubit extends Cubit<FeedbakState> {
  final HomeScreenUseCase useCase;
  FeebakCubit(this.useCase) : super(FeedbakState());

  void temoignageChanged(String value) {
    final temoignage = TextFields.dirty(value);
    emit(state.copyWith(temoignage: temoignage, status: Formz.validate([temoignage])));
  }

  Future<void> sendTemoignage() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await useCase.repository.sendTemoignage(state.temoignage.value);
    result.fold((failure) {
      emit(
        state.copyWith(
          message: failure,
          status: FormzStatus.submissionFailure,
        ),
      );
    }, (data) {
      emit(
        FeedbakState(
          testimonyResponse: data,
          status: FormzStatus.submissionSuccess,
        ),
      );
    });

  }

  initState(){
    emit(
      FeedbakState(
        testimonyResponse: null,
        temoignage: const TextFields.pure(),
        message: null,
        status: FormzStatus.pure,
      ),
    );
  }
}
