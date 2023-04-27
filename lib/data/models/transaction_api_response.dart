class TransactionApiResponse {
  bool? success;
  TransactionApi? data;
  String? message;

  TransactionApiResponse({this.success, this.data, this.message});

  TransactionApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new TransactionApi.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class TransactionApi {
  String? url;
  int? transactionId;

  TransactionApi({this.url, this.transactionId});

  TransactionApi.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['transaction_id'] = this.transactionId;
    return data;
  }
}
