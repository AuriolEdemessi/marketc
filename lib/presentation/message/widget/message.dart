import 'package:marketscc/data/models/user_model.dart';

class Message {
  UserModel? user;
  String? lastMessage;
  bool? unread;
  int? number;
  Message(this.user, this.lastMessage, {this.unread=false, this.number});
}
