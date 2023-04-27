import 'trx_model.dart';

import 'dart:convert';

TrxResponse trxResponseFromJson(String str) => TrxResponse.fromJson(json.decode(str));

String trxResponseToJson(TrxResponse data) => json.encode(data.toJson());

class TrxResponse {
  TrxResponse({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final TrxData? data;

  factory TrxResponse.fromJson(Map<String, dynamic> json) => TrxResponse(
    success: json["success"],
    message: json["message"],
    data: TrxData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class TrxData {
  TrxData({
     this.trx,
     this.wallet,
     this.approved,
     this.pending,
     this.declined,
     this.bpend,
     this.bcharge,
     this.bacharge,
     this.bdeccharge,
     this.bdecline,
     this.buy,
     this.sell,
     this.bonus,
     this.basic,
     this.spend,
     this.sdecline,
     this.time,
     this.chatUrl,
     this.myRefer,
     this.affiliation,
  });

  final Trx? trx;
  final List<Wallet>? wallet;
  final num? approved;
  final num? pending;
  final num? declined;
  final num? bpend;
  final double? bcharge;
  final num? bacharge;
  final num? bdeccharge;
  final num? bdecline;
  final num? buy;
  final num? sell;
  final String? bonus;
  final String? basic;
  final int? spend;
  final int? sdecline;
  final DateTime? time;
  final String? chatUrl;
  final String? myRefer;
  final List<dynamic>? affiliation;

  factory TrxData.fromJson(Map<String, dynamic> json) => TrxData(
    trx: Trx.fromJson(json["trx"]),
    wallet: List<Wallet>.from(json["wallet"].map((x) => Wallet.fromJson(x))),
    approved: json["approved"],
    pending: json["pending"],
    declined: json["declined"],
    bpend: json["bpend"],
    bcharge: json["bcharge"].toDouble(),
    bacharge: json["bacharge"],
    bdeccharge: json["bdeccharge"],
    bdecline: json["bdecline"],
    buy: json["buy"],
    sell: json["sell"],
    bonus: json["bonus"],
    basic: json["basic"],
    spend: json["spend"],
    sdecline: json["sdecline"],
    time: DateTime.parse(json["time"]),
    chatUrl: json["chat_url"],
    myRefer: json["my_refer"],
    affiliation: List<dynamic>.from(json["affiliation"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "trx": trx?.toJson(),
    "wallet": List<dynamic>.from(wallet!.map((x) => x.toJson())),
    "approved": approved,
    "pending": pending,
    "declined": declined,
    "bpend": bpend,
    "bcharge": bcharge,
    "bacharge": bacharge,
    "bdeccharge": bdeccharge,
    "bdecline": bdecline,
    "buy": buy,
    "sell": sell,
    "bonus": bonus,
    "basic": basic,
    "spend": spend,
    "sdecline": sdecline,
    "time": time?.toIso8601String(),
    "chat_url": chatUrl,
    "my_refer": myRefer,
    "affiliation": List<dynamic>.from(affiliation!.map((x) => x)),
  };
}

class Trx {
  Trx({
     this.data,
  });

  final List<TrxModel>? data;

  factory Trx.fromJson(Map<String, dynamic> json) => Trx(
    data: List<TrxModel>.from(json["data"].map((x) => TrxModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

/*class Trx {
  List<TrxModel>? data;

  Trx(
      {
        this.data,
      });

  Trx.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TrxModel>[];
      json['data'].forEach((v) {
        data!.add(new TrxModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/

class Wallet {
  Wallet({
     this.totalPurchase,
     this.totalSale,
     this.deviseName,
     this.deviseSymbol,
     this.currencyImage,
     this.currencyTypeId,
     this.currencyTypeName,
     this.basic,
  });

  final String? totalPurchase;
  final String? totalSale;
  final String? deviseName;
  final String? deviseSymbol;
  final String? currencyImage;
  final int? currencyTypeId;
  final String? currencyTypeName;
  final String? basic;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    totalPurchase: json["total_purchase"],
    totalSale: json["total_sale"],
    deviseName: json["devise_name"],
    deviseSymbol: json["devise_symbol"],
    currencyImage: json["currency_image"],
    currencyTypeId: json["currency_type_id"],
    currencyTypeName: json["currency_type_name"],
    basic: json["basic"],
  );

  Map<String, dynamic> toJson() => {
    "total_purchase": totalPurchase,
    "total_sale": totalSale,
    "devise_name": deviseName,
    "devise_symbol": deviseSymbol,
    "currency_image": currencyImage,
    "currency_type_id": currencyTypeId,
    "currency_type_name": currencyTypeName,
    "basic": basic,
  };
}

