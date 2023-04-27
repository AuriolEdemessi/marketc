class AffiliationResponse {
  bool? success;
  String? message;
  MetaData? metaData;

  AffiliationResponse({this.success, this.message, this.metaData});

  AffiliationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    metaData = json['data'] != null ? new MetaData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.metaData != null) {
      data['data'] = this.metaData!.toJson();
    }
    return data;
  }
}

class MetaData {
  String? myRefer;
  List<Affiliation>? affiliation;

  MetaData({this.myRefer, this.affiliation});

  MetaData.fromJson(Map<String, dynamic> json) {
    myRefer = json['my_refer'];
    if (json['affiliation'] != null) {
      affiliation = <Affiliation>[];
      json['affiliation'].forEach((v) {
        affiliation!.add(new Affiliation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['my_refer'] = this.myRefer;
    if (this.affiliation != null) {
      data['affiliation'] = this.affiliation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Affiliation {
  String? username;

  Affiliation({this.username});

  Affiliation.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}
