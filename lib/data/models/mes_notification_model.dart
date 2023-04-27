import 'package:equatable/equatable.dart';

class MesNotificationModel {
  int? id;
  String? title;
  String? details;
  int? status;
  String? date;
  String? logo;

  MesNotificationModel({this.id, this.title, this.details, this.status, this.date, this.logo});

  MesNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    status = json['status'];
    date = json['date'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['status'] = this.status;
    data['date'] = this.date;
    data['logo'] = this.logo;
    return data;
  }
}

class NotificationResponse extends Equatable {

  final List<MesNotificationModel> notificationList;

  const NotificationResponse({required this.notificationList});

  factory NotificationResponse.fromJson(json) => NotificationResponse(notificationList: List<MesNotificationModel>.from((json).map((x) => MesNotificationModel.fromJson(x))),);

  //Map<String, dynamic> toJson() => {'annonces': List<dynamic>.from(annonceList.map((x) => x.toJson())),};

  @override
  List<Object> get props => [notificationList];
}