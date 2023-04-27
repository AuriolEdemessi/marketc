import 'package:equatable/equatable.dart';

class MesAnnonceModel {
  int? id;
  int? userId;
  String? taux;
  String? giveId;
  String? getId;
  String? qgive;
  String? qget;
  String? reserve;
  String? mMin;
  String? mMax;
  String? createdAt;
  String? updatedAt;
  String? trId;
  String? adresseNum;
  int? status;
  String? etat;
  String? giveCurrenciesName;
  String? giveCurrencyAcronym;
  String? giveCurrenciesImage;
  String? getCurrenciesName;
  String? getCurrencyAcronym;
  String? getCurrenciesImage;
  int? giveCurrenciesCoin;
  int? getCurrenciesCoin;
  String? getCurrenciesBasic;
  String? giveCurrenciesBasic;

  MesAnnonceModel(
      {this.id,
        this.userId,
        this.taux,
        this.giveId,
        this.getId,
        this.qgive,
        this.qget,
        this.reserve,
        this.mMin,
        this.mMax,
        this.createdAt,
        this.updatedAt,
        this.trId,
        this.adresseNum,
        this.status,
        this.etat,
        this.giveCurrenciesName,
        this.giveCurrencyAcronym,
        this.giveCurrenciesImage,
        this.getCurrenciesName,
        this.getCurrencyAcronym,
        this.getCurrenciesImage,
        this.giveCurrenciesCoin,
        this.getCurrenciesCoin,
        this.getCurrenciesBasic,
        this.giveCurrenciesBasic});

  MesAnnonceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    taux = json['taux'];
    giveId = json['give_id'];
    getId = json['get_id'];
    qgive = json['qgive'];
    qget = json['qget'];
    reserve = json['reserve'];
    mMin = json['m_min'];
    mMax = json['m_max'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trId = json['tr_id'];
    adresseNum = json['adresse_num'];
    status = json['status'];
    etat = json['etat'];
    giveCurrenciesName = json['give_currencies_name'];
    giveCurrencyAcronym = json['give_currency_acronym'];
    giveCurrenciesImage = json['give_currencies_image'];
    getCurrenciesName = json['get_currencies_name'];
    getCurrencyAcronym = json['get_currency_acronym'];
    getCurrenciesImage = json['get_currencies_image'];
    giveCurrenciesCoin = json['give_currencies_coin'];
    getCurrenciesCoin = json['get_currencies_coin'];
    getCurrenciesBasic = json['get_currencies_basic'];
    giveCurrenciesBasic = json['give_currencies_basic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['taux'] = this.taux;
    data['give_id'] = this.giveId;
    data['get_id'] = this.getId;
    data['qgive'] = this.qgive;
    data['qget'] = this.qget;
    data['reserve'] = this.reserve;
    data['m_min'] = this.mMin;
    data['m_max'] = this.mMax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['tr_id'] = this.trId;
    data['adresse_num'] = this.adresseNum;
    data['status'] = this.status;
    data['etat'] = this.etat;
    data['give_currencies_name'] = this.giveCurrenciesName;
    data['give_currency_acronym'] = this.giveCurrencyAcronym;
    data['give_currencies_image'] = this.giveCurrenciesImage;
    data['get_currencies_name'] = this.getCurrenciesName;
    data['get_currency_acronym'] = this.getCurrencyAcronym;
    data['get_currencies_image'] = this.getCurrenciesImage;
    data['give_currencies_coin'] = this.giveCurrenciesCoin;
    data['get_currencies_coin'] = this.getCurrenciesCoin;
    data['get_currencies_basic'] = this.getCurrenciesBasic;
    data['give_currencies_basic'] = this.giveCurrenciesBasic;
    return data;
  }
}


class MesAnnoncesResponse extends Equatable {

  final List<MesAnnonceModel> mesAnnonceList;

  const MesAnnoncesResponse({required this.mesAnnonceList});

  factory MesAnnoncesResponse.fromJson(json) => MesAnnoncesResponse(mesAnnonceList: List<MesAnnonceModel>.from((json).map((x) => MesAnnonceModel.fromJson(x))),);

  //Map<String, dynamic> toJson() => {'annonces': List<dynamic>.from(annonceList.map((x) => x.toJson())),};

  @override
  List<Object> get props => [mesAnnonceList];
}