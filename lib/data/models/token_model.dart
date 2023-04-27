import 'package:equatable/equatable.dart';

class TokenModel extends Equatable{
  bool? success;
  String? token;
  String? message;

  TokenModel({this.success, this.token, this.message});

  TokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['token'] = token;
    data['message'] = message;
    return data;
  }

  @override
  List<Object?> get props => [
    success,
    token,
    message,
  ];
}