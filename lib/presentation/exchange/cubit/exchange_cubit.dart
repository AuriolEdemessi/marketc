import '../../../export.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final HomeScreenUseCase useCase;

  ExchangeCubit(this.useCase) : super(ExchangeState());

  Future<void> buyCoin({annonceId, quantity, text}) async {
    Map<String, dynamic> body= {
    "announcement_id": annonceId,
    "quantity_to_exchange": quantity,
    "text": text
    };
    emit(state.copyWith(buyCoinStatus: FormzStatus.submissionInProgress));
    //emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionInProgress));
    final result = await useCase.buyCoin(body);
    result.fold((failure) {
      emit(state.copyWith(message: failure, buyCoinStatus: FormzStatus.submissionFailure));
      //emit(PortefeuillesState(createWalletStatus:FormzStatus.submissionFailure, message: failure));
    }, (data) async{
      emit(state.copyWith(buyCoinResponse: data, buyCoinStatus: FormzStatus.submissionSuccess));
    });
  }

  Future<void> sendProof({data}) async {

    emit(state.copyWith(sendProofStatus: FormzStatus.submissionInProgress));

    final result = await useCase.sendProof(data);

    result.fold((failure) {
      emit(state.copyWith(sendProofStatus: FormzStatus.submissionFailure, message: failure));
    }, (data) {
      emit(state.copyWith(sucessMessage:data, sendProofStatus: FormzStatus.submissionSuccess,));
    });
  }

Future<void> resetStatut()async{
    emit(ExchangeState(sendProofStatus: FormzStatus.pure, buyCoinStatus:FormzStatus.pure));
}

}