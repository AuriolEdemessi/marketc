import 'package:dio/dio.dart';

import '../../../export.dart';

class MesAnnoncesCubit extends Cubit<MesAnnoncesState> {

  final HomeScreenUseCase useCase;

  MesAnnoncesCubit(this.useCase) : super(MesAnnoncesState());


  Future<List<MesAnnonceModel>> fetch(page) async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(
        pathUrl: "announcement/history?page=$page");
    return MesAnnoncesResponse.fromJson(response.data['data']['data']).mesAnnonceList;
  }
}
