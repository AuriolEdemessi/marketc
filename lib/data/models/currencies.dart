class Currencies {
  int? currencyId;
  String? currencyName;
  String? currencyAcronym;
  String? currencyImage;
  int? currencyTypeId;

  Currencies(
      {this.currencyId,
        this.currencyName,
        this.currencyAcronym,
        this.currencyImage,
        this.currencyTypeId});

  Currencies.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    currencyAcronym = json['currency_acronym'];
    currencyImage = json['currency_image'];
    currencyTypeId = json['currency_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['currency_acronym'] = this.currencyAcronym;
    data['currency_image'] = this.currencyImage;
    data['currency_type_id'] = this.currencyTypeId;
    return data;
  }
}