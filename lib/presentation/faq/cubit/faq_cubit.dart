import '../../../export.dart';

class FaqCubit extends Cubit<FaqState> {
  final HomeScreenUseCase homeScreenUseCase;

  FaqCubit(this.homeScreenUseCase) : super(FaqState());

  Future<void> fetchFaq() async {
    emit(
      FaqState(
        faqStatus: FormzStatus.submissionInProgress,
      ),
    );
    final result = await homeScreenUseCase.getFaq();

    result.fold((failure) {
      emit(
        FaqState(
          faqStatus: FormzStatus.submissionFailure,
          message: failure
        ),
      );
    }, (data) {
      emit(
        FaqState(
          faqList: data.faqList,
          faqStatus: FormzStatus.submissionSuccess,
        ),
      );
    });
  }

}