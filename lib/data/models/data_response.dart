import 'package:equatable/equatable.dart';

class DataResponse extends Equatable{
  final bool? success;
  final String? message;
  final String? email;
  final String? token;

  DataResponse({this.success, this.message, this.email, this.token});
  factory DataResponse.fromJson(Map<String, dynamic> json)=> DataResponse(
    success : json['success'],
    message : json['message'],
    token : json['token'],
    email : json['email'],
  );

  Map<String, dynamic> toJson() => {
  'success': success,
  'message': message,
  'token': token,
  'email': email,
  };

  @override
  List<Object?> get props => [success, message, token, email];
}