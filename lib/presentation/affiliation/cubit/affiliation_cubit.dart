import '../../../export.dart';

class AffiliationCubit extends Cubit<AffiliationState> {
  final HomeScreenUseCase homeScreenUseCase;

  AffiliationCubit(this.homeScreenUseCase) : super(AffiliationState());

  Future<void> fetchAffiliation() async {
    emit(
      AffiliationState(
        affiliationStatus: FormzStatus.submissionInProgress,
      ),
    );
    final result = await homeScreenUseCase.getAffiliation();

    result.fold((failure) {
      emit(
        AffiliationState(
            affiliationStatus: FormzStatus.submissionFailure,
            message: failure
        ),
      );
    }, (data) {
      emit(
        AffiliationState(
          data: data,
          affiliationStatus: FormzStatus.submissionSuccess,
        ),
      );
    });
  }

}