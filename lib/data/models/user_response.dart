import 'user_model.dart';

class UserResponse {
  bool? success;
  String? message;
  UserModel? user;

  UserResponse({this.success, this.message, this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['data'] = this.user!.toJson();
    }
    return data;
  }
}







