import 'package:marketscc/export.dart';
import 'package:dio/dio.dart';

import '../../../../data/models/trx_model.dart';

class PurchaseCubit extends Cubit<PurchaseState> {

  final HomeScreenUseCase homeScreenUseCase;

  PurchaseCubit(this.homeScreenUseCase) : super(PurchaseState());

  Future<void> fetchPurchaseList() async {

    emit(state.copyWith(status:FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getListPurchase();

    result.fold((failure) {
      emit(state.copyWith(status:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(trxList: data, status:FormzStatus.submissionSuccess));
    });
  }


  Future<List<TrxModel>> fetchPurchase(page) async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(pathUrl: "exchange/history/purchases?page=$page");
    // Response response = await baseApiClient.get(pathUrl: "exchange/history/sales&page=$page");
    return TrxList.fromJson(response.data['data']['data']).trxList;
  }
}