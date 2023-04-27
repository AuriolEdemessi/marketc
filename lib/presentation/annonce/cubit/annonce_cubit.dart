import 'package:dio/dio.dart';

import '../../../export.dart';

class AnnonceCubit extends Cubit<AnnonceState> {

  final HomeScreenUseCase homeScreenUseCase;

  AnnonceCubit(this.homeScreenUseCase) : super(AnnonceState());

  Future<void> fetchAnnonceList() async {
    emit(state.copyWith(annonceListStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getAnnonces();
    result.fold((failure) {
      emit(state.copyWith(
          message: failure, annonceListStatus: FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(
          annoncesList: data,
          annonceListStatus: FormzStatus.submissionSuccess));
    });
  }

  Future<void> deleteAnnonceById(id) async {
    emit(state.copyWith(deleteAnnonceStatus: FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.deleteAnnonceById(id);
    result.fold((failure) {
      emit(state.copyWith(
          message: failure, deleteAnnonceStatus: FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(
          sucessMessage: data,
          deleteAnnonceStatus: FormzStatus.submissionSuccess));
    });
  }

  Future<void> fetchExchangeListe() async {

    emit(state.copyWith(deviseListStatus:FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getListCurrencyExchange();

    result.fold((failure) {
      emit(state.copyWith(deviseListStatus:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(deviseList: data, deviseListStatus:FormzStatus.submissionSuccess));
    });
  }

  Future<void> sellCoin({currencyToSell, quantityToSell, currencyToGet, quantityToGet, walletId, reserve, min, max}) async {

    emit(state.copyWith(sellCoinStatus:FormzStatus.submissionInProgress));

   Map<String, dynamic> body={
     "currency_to_sell": currencyToSell,
     "quantity_to_sell": quantityToSell,
     "currency_to_get": currencyToGet,
     "quantity_to_get": quantityToGet,
     "wallet_id": walletId,
     "reserve": reserve,
     "m_min": min,
     "m_max": max
   };

    final result = await homeScreenUseCase.repository.sellCoin(body);

    result.fold((failure) {
      emit(state.copyWith(message: failure, sellCoinStatus:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(sucessMessage: data, sellCoinStatus:FormzStatus.submissionSuccess));
    });
  }

  Future<void> updateAnnonce({announcementId, quantityToSell, quantityToGet, walletId, reserve, min, max}) async {

    emit(state.copyWith(updateAnnonceStatus:FormzStatus.submissionInProgress));

   Map<String, dynamic> body={
     "announcement_id": announcementId,
     "quantity_to_sell": quantityToSell,
     "quantity_to_get": quantityToGet,
     "wallet_id": walletId,
     "reserve": reserve,
     "m_min": min,
     "m_max": max
   };

    final result = await homeScreenUseCase.repository.updateAnnonce(body);

    result.fold((failure) {
      emit(state.copyWith(message: failure, updateAnnonceStatus:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(sucessMessage: data, updateAnnonceStatus:FormzStatus.submissionSuccess));
    });
  }

  Future<List<AnnonceModel>> fetch({page, required int giveId, required int getId}) async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(
        pathUrl: "getrates?give_id=${giveId==0?"all":giveId}&get_id=${getId==0?"all":getId}&meilleur_taux=updated_at&page=$page");
    return AnnonceResponse.fromJson(response.data['data']['data']).annonceList;
  }

  Future<void> resetStatut()async{
    emit(AnnonceState(sellCoinStatus: FormzStatus.pure));
  }
}
