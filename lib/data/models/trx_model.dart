import 'payment_api.dart';

class TrxModel {
  TrxModel({
     this.id,
     this.trxId,
     this.trxType,
     this.userId,
     this.userIdRevendeur,
     this.status,
     this.qGive,
     this.qGet,
     this.taux,
     this.charge,
     this.paymentProof,
     this.currencyGetId,
     this.currencyGetName,
     this.currencyGetAcronym,
     this.currencyGetBasic,
     this.currencyGetImage,
     this.currencyGetApi,
     this.currencyGetTypeName,
     this.currencyGetAddress,
     this.currencyGetTypeId,
     this.currencyGiveId,
     this.currencyGiveName,
     this.currencyGiveAdress,
     this.currencyGiveAcronym,
     this.currencyGiveBasic,
     this.currencyGiveImage,
     this.currencyGiveApi,
     this.currencyGiveTypeName,
     this.currencyGiveTypeId,
     this.date,
     //this.timeout,
     this.resteTimeout,
     this.trxcancel,
     this.paymentApiWay,
  });

  final int? id;
  final String? trxId;
  final String? trxType;
  final int? userId;
  final int? userIdRevendeur;
  final String? status;
  final String? qGive;
  final String? qGet;
  final String? taux;
  final String? charge;
  final String? paymentProof;
  final int? currencyGetId;
  final String? currencyGetName;
  final String? currencyGetAddress;
  final String? currencyGetAcronym;
  final String? currencyGetBasic;
  final String? currencyGetImage;
  final int? currencyGetApi;
  final String? currencyGetTypeName;
  final int? currencyGetTypeId;
  final int? currencyGiveId;
  final String? currencyGiveName;
  final String? currencyGiveAdress;
  final String? currencyGiveAcronym;
  final String? currencyGiveBasic;
  final String? currencyGiveImage;
  final int? currencyGiveApi;
  final String? currencyGiveTypeName;
  final int? currencyGiveTypeId;
  final String? date;
 // final int? timeout;
  final int? resteTimeout;
  final String? trxcancel;
  final PaymentApiWay? paymentApiWay;

  factory TrxModel.fromJson(Map<String, dynamic> json) => TrxModel(
    id: json["id"],
    trxId: json["trx_id"],
    trxType: json["trx_type"],
    userId: json["user_id"],
    userIdRevendeur: json["user_id_revendeur"],
    status: json["status"],
    qGive: json["q_give"],
    qGet: json["q_get"],
    taux: json["taux"],
    charge: json["charge"],
    paymentProof: json["payment_proof"],
    currencyGetId: json["currency_get_id"],
    currencyGetName: json["currency_get_name"],
    currencyGetAcronym: json["currency_get_acronym"],
    currencyGetAddress: json["currency_get_address"],
    currencyGetBasic: json["currency_get_basic"],
    currencyGetImage: json["currency_get_image"],
    currencyGetApi: json["currency_get_API"],
    currencyGetTypeName: json["currency_get_type_name"],
    currencyGetTypeId: json["currency_get_type_id"],
    currencyGiveId: json["currency_give_id"],
    currencyGiveName: json["currency_give_name"],
    currencyGiveAdress: json["currency_give_address"],
    currencyGiveAcronym: json["currency_give_acronym"],
    currencyGiveBasic: json["currency_give_basic"],
    currencyGiveImage: json["currency_give_image"],
    currencyGiveApi: json["currency_give_API"],
    currencyGiveTypeName: json["currency_give_type_name"],
    currencyGiveTypeId: json["currency_give_type_id"],
    date: json["date"],
    //timeout: json["timeout"],
    resteTimeout: json["reste_timeout"],
    trxcancel: json["trxcancel"],
    paymentApiWay:json["payment_api_way"]==null?null: PaymentApiWay.fromJson(json["payment_api_way"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trx_id": trxId,
    "trx_type": trxType,
    "user_id": userId,
    "user_id_revendeur": userIdRevendeur,
    "status": status,
    "q_give": qGive,
    "q_get": qGet,
    "taux": taux,
    "charge": charge,
    "payment_proof": paymentProof,
    "currency_get_id": currencyGetId,
    "currency_get_name": currencyGetName,
    "currency_get_address": currencyGetAddress,
    "currency_get_acronym": currencyGetAcronym,
    "currency_get_basic": currencyGetBasic,
    "currency_get_image": currencyGetImage,
    "currency_get_API": currencyGetApi,
    "currency_get_type_name": currencyGetTypeName,
    "currency_get_type_id": currencyGetTypeId,
    "currency_give_id": currencyGiveId,
    "currency_give_name": currencyGiveName,
    "currency_give_address": currencyGiveAdress,
    "currency_give_acronym": currencyGiveAcronym,
    "currency_give_basic": currencyGiveBasic,
    "currency_give_image": currencyGiveImage,
    "currency_give_API": currencyGiveApi,
    "currency_give_type_name": currencyGiveTypeName,
    "currency_give_type_id": currencyGiveTypeId,
    "date": date,
   // "timeout": timeout,
    "reste_timeout": resteTimeout,
    "trxcancel": trxcancel,
    "payment_api_way": paymentApiWay?.toJson(),
  };
}

class TrxList{
  List<TrxModel> trxList;
  TrxList({required this.trxList});
  factory TrxList.fromJson(json) => TrxList(trxList: List<TrxModel>.from((json).map((x) => TrxModel.fromJson(x))),);
}