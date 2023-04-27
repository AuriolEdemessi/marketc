class DeleteTrxResponse {
  bool? success;
  String? message;
  DeleteTrx? data;

  DeleteTrxResponse({this.success, this.message, this.data});

  DeleteTrxResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DeleteTrx.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeleteTrx {
  int? id;
  int? userId;
  int? userIdRevendeur;
  String? amount;
  String? mainAmo;
  String? amountpaid;
  String? depositor;
  String? tnum;
  String? image;
  String? charge;
  String? type;
  String? wallet;
  int? currencyId;
  String? rate;
  String? price;
  String? getamo;
  int? method;
  String? bank;
  String? remark;
  String? trx;
  String? status;
  String? bankname;
  String? accountname;
  String? accountnumber;
  String? gateway;
  String? timeout;
  String? createdAt;
  String? updatedAt;
  String? trIdRevendeur;
  String? portefeuilleManuelle;

  DeleteTrx(
      {this.id,
        this.userId,
        this.userIdRevendeur,
        this.amount,
        this.mainAmo,
        this.amountpaid,
        this.depositor,
        this.tnum,
        this.image,
        this.charge,
        this.type,
        this.wallet,
        this.currencyId,
        this.rate,
        this.price,
        this.getamo,
        this.method,
        this.bank,
        this.remark,
        this.trx,
        this.status,
        this.bankname,
        this.accountname,
        this.accountnumber,
        this.gateway,
        this.timeout,
        this.createdAt,
        this.updatedAt,
        this.trIdRevendeur,
        this.portefeuilleManuelle});

  DeleteTrx.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userIdRevendeur = json['user_id_revendeur'];
    amount = json['amount'];
    mainAmo = json['main_amo'];
    amountpaid = json['amountpaid'];
    depositor = json['depositor'];
    tnum = json['tnum'];
    image = json['image'];
    charge = json['charge'];
    type = json['type'];
    wallet = json['wallet'];
    currencyId = json['currency_id'];
    rate = json['rate'];
    price = json['price'];
    getamo = json['getamo'];
    method = json['method'];
    bank = json['bank'];
    remark = json['remark'];
    trx = json['trx'];
    status = json['status'];
    bankname = json['bankname'];
    accountname = json['accountname'];
    accountnumber = json['accountnumber'];
    gateway = json['gateway'];
    timeout = json['timeout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trIdRevendeur = json['tr_id_revendeur'];
    portefeuilleManuelle = json['portefeuille_manuelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_id_revendeur'] = this.userIdRevendeur;
    data['amount'] = this.amount;
    data['main_amo'] = this.mainAmo;
    data['amountpaid'] = this.amountpaid;
    data['depositor'] = this.depositor;
    data['tnum'] = this.tnum;
    data['image'] = this.image;
    data['charge'] = this.charge;
    data['type'] = this.type;
    data['wallet'] = this.wallet;
    data['currency_id'] = this.currencyId;
    data['rate'] = this.rate;
    data['price'] = this.price;
    data['getamo'] = this.getamo;
    data['method'] = this.method;
    data['bank'] = this.bank;
    data['remark'] = this.remark;
    data['trx'] = this.trx;
    data['status'] = this.status;
    data['bankname'] = this.bankname;
    data['accountname'] = this.accountname;
    data['accountnumber'] = this.accountnumber;
    data['gateway'] = this.gateway;
    data['timeout'] = this.timeout;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['tr_id_revendeur'] = this.trIdRevendeur;
    data['portefeuille_manuelle'] = this.portefeuilleManuelle;
    return data;
  }
}
