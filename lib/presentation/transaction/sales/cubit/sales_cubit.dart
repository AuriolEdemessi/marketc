import 'package:marketscc/export.dart';
import 'package:dio/dio.dart';

import '../../../../data/models/trx_model.dart';

class SalesCubit extends Cubit<SalesState> {

  final HomeScreenUseCase homeScreenUseCase;

  SalesCubit(this.homeScreenUseCase) : super(SalesState());

  Future<void> fetchSalesList() async {

    emit(state.copyWith(status:FormzStatus.submissionInProgress));
    final result = await homeScreenUseCase.getListSales();

    result.fold((failure) {
      emit(state.copyWith(status:FormzStatus.submissionFailure));
    }, (data) {
      emit(state.copyWith(trxList: data, status:FormzStatus.submissionSuccess));
    });
  }


  Future<List<TrxModel>> fetchSales(page) async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(pathUrl: "exchange/history/sales?page=$page");
   // Response response = await baseApiClient.get(pathUrl: "exchange/history/sales&page=$page");
    return TrxList.fromJson(response.data['data']['data']).trxList;
  }
}