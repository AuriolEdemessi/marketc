import '../../export.dart';
import 'payment_api.dart';


class BuyCoinResponse {
  bool? success;
  String? message;
  BuyCoin? buyCoin;

  BuyCoinResponse({this.success, this.message, this.buyCoin});

  BuyCoinResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    buyCoin = json['data'] != null ? new BuyCoin.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.buyCoin != null) {
      data['data'] = this.buyCoin!.toJson();
    }
    return data;
  }
}

class BuyCoin {
  String? trxId;
  String? qteToPay;
  String? qteToGet;
  PaymentWallet? paymentWallet;
  ReceiverWallet? receiverWallet;
  PaymentApiWay? paymentApiWay;

  BuyCoin(
      {this.trxId,
        this.qteToPay,
        this.qteToGet,
        this.paymentWallet,
        this.receiverWallet,
        this.paymentApiWay});

  BuyCoin.fromJson(Map<String, dynamic> json) {
    trxId = json['trx_id'];
    qteToPay = json['qte_to_pay'];
    qteToGet = json['qte_to_get'];
    paymentWallet = json['payment_wallet'] != null
        ? new PaymentWallet.fromJson(json['payment_wallet'])
        : null;
    receiverWallet = json['receiver_wallet'] != null
        ? new ReceiverWallet.fromJson(json['receiver_wallet'])
        : null;
    paymentApiWay = json['payment_api_way'] != null
        ? new PaymentApiWay.fromJson(json['payment_api_way'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trx_id'] = this.trxId;
    data['qte_to_pay'] = this.qteToPay;
    data['qte_to_get'] = this.qteToGet;
    if (this.paymentWallet != null) {
      data['payment_wallet'] = this.paymentWallet!.toJson();
    }
    if (this.receiverWallet != null) {
      data['receiver_wallet'] = this.receiverWallet!.toJson();
    }
    if (this.paymentApiWay != null) {
      data['payment_api_way'] = this.paymentApiWay!.toJson();
    }
    return data;
  }
}

class PaymentWallet {
  int? id;
  int? status;
  CurrencyType? currencyType;
  Currency? currency;
  String? address;
  bool? isAdminWallet;

  PaymentWallet(
      {this.id,
        this.status,
        this.currencyType,
        this.currency,
        this.address,
        this.isAdminWallet});

  PaymentWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    currencyType = json['currency_type'] != null
        ? new CurrencyType.fromJson(json['currency_type'])
        : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    address = json['address'];
    isAdminWallet = json['is_admin_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.currencyType != null) {
      data['currency_type'] = this.currencyType!.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['address'] = this.address;
    data['is_admin_wallet'] = this.isAdminWallet;
    return data;
  }
}

/*class CurrencyType {
  int? currencyTypeId;
  String? currencyTypeName;

  CurrencyType({this.currencyTypeId, this.currencyTypeName});

  CurrencyType.fromJson(Map<String, dynamic> json) {
    currencyTypeId = json['currency_type_id'];
    currencyTypeName = json['currency_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_type_id'] = this.currencyTypeId;
    data['currency_type_name'] = this.currencyTypeName;
    return data;
  }
}
*/

class Currency {
  int? currencyId;
  String? currencyName;
  String? currencyAcronym;
  String? currencyImage;
  String? currencyBasic;

  Currency(
      {this.currencyId,
        this.currencyName,
        this.currencyAcronym,
        this.currencyImage,
        this.currencyBasic});

  Currency.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    currencyAcronym = json['currency_acronym'];
    currencyImage = json['currency_image'];
    currencyBasic = json['currency_basic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['currency_acronym'] = this.currencyAcronym;
    data['currency_image'] = this.currencyImage;
    data['currency_basic'] = this.currencyBasic;
    return data;
  }
}

class ReceiverWallet {
  int? id;
  int? status;
  CurrencyType? currencyType;
  Currency? currency;
  String? address;

  ReceiverWallet(
      {this.id, this.status, this.currencyType, this.currency, this.address});

  ReceiverWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    currencyType = json['currency_type'] != null
        ? new CurrencyType.fromJson(json['currency_type'])
        : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.currencyType != null) {
      data['currency_type'] = this.currencyType!.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['address'] = this.address;
    return data;
  }
}

class BuyInfo{
  BuyInfo({
    required this.trxId,
    required this.back,
    required this.address,
    required this.currencyName,
  });
  String trxId;
  String address;
  String currencyName;
  bool back;
}



