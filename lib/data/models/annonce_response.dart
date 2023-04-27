
import 'package:equatable/equatable.dart';

import '../../export.dart';

/*class AnnonceResponse {
  bool? success;
  String? messages;
  DataRes? data;

  AnnonceResponse({this.success, this.messages, this.data});

  AnnonceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messages = json['messages'];
    data = json['data'] != null ? new DataRes.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


class DataRes {
  int? currentPage;
  List<AnnonceModel>? data;
  String? firstPageUrl;
  int? from;
  String? path;
  int? perPage;
  int? to;

  DataRes(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.path,
        this.perPage,
        this.to});

  DataRes.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AnnonceModel>[];
      json['data'].forEach((v) {
        data!.add(new AnnonceModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    return data;
  }
}*/

class AnnonceResponse extends Equatable {

  final List<AnnonceModel> annonceList;

  const AnnonceResponse({required this.annonceList});

  factory AnnonceResponse.fromJson(json) => AnnonceResponse(annonceList: List<AnnonceModel>.from((json).map((x) => AnnonceModel.fromJson(x))),);

  //Map<String, dynamic> toJson() => {'annonces': List<dynamic>.from(annonceList.map((x) => x.toJson())),};

  @override
  List<Object> get props => [annonceList];
}
