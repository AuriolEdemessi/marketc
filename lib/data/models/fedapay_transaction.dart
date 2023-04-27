class FedaPayTransaction {
  String? klass;
  int? id;
  String? reference;
  int? amount;
  String? description;
  String? callbackUrl;
  String? status;
  int? customerId;
  int? currencyId;
  String? operation;

  FedaPayTransaction(
      {this.klass,
        this.id,
        this.reference,
        this.amount,
        this.description,
        this.callbackUrl,
        this.status,
        this.customerId,
        this.currencyId,
        this.operation});

  FedaPayTransaction.fromJson(Map<String, dynamic> json) {
    klass = json['klass'];
    id = json['id'];
    reference = json['reference'];
    amount = json['amount'];
    description = json['description'];
    callbackUrl = json['callback_url'];
    status = json['status'];
    customerId = json['customer_id'];
    currencyId = json['currency_id'];
    operation = json['operation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['klass'] = this.klass;
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['callback_url'] = this.callbackUrl;
    data['status'] = this.status;
    data['customer_id'] = this.customerId;
    data['currency_id'] = this.currencyId;
    data['operation'] = this.operation;
    return data;
  }
}