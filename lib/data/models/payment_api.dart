class PaymentApiWay {
  PaymentApiWay({
     this.id,
     this.apiName,
     this.statut,
     this.publicKey,
  });

  final int? id;
  final String? apiName;
  final int? statut;
  final dynamic publicKey;

  factory PaymentApiWay.fromJson(Map<String, dynamic> json) => PaymentApiWay(
    id: json["id"],
    apiName: json["api_name"],
    statut: json["statut"],
    publicKey: json["public_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "api_name": apiName,
    "statut": statut,
    "public_key": publicKey,
  };
}