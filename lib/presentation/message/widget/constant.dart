import '../../../data/models/user_model.dart';
import '../../../export.dart';
import 'chat_bubble.dart';
import 'message.dart';


List<Message> listMessage = [
  Message(UserModel(fname: "Rozanne", lname:"Barrientes", image: ""), "A wonderful serenity has taken", unread: true, number: 2),
  Message(UserModel(fname: "Rozanne", lname:"Barrientes", image: ""), "A wonderful serenity has taken", unread: true, number: 2),
  Message(UserModel(fname: "Rozanne", lname:"Barrientes", image: ""), "A wonderful serenity has taken", unread: true, number: 2),
  Message(UserModel(fname: "Rozanne", lname:"Barrientes", image: ""), "A wonderful serenity has taken", unread: true, number: 2),
  Message(UserModel(fname: "Rozanne", lname:"Barrientes", image: ""), "A wonderful serenity has taken", unread: true, number: 2),
];

List<ChatBubble> listChatBubble = [
  ChatBubble("Hello","4:34 PM", true),
  ChatBubble("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout","4:34 PM", false),
  ChatBubble("How are you?😜","4:35 PM", true),
  ChatBubble("Nice, bro🤟","4:35 PM", false),
  ChatBubble("I heard u guys launching new product?","4:35 PM", true),
  ChatBubble("Yes, It calls UiHunt","4:35 PM", false),
  ChatBubble("Thats Awesome 😍","4:35 PM", true),
  ChatBubble("Hi","4:34 PM", false),
  ChatBubble("How are you?😜","4:35 PM", true),
  ChatBubble("Nice, bro🤟","4:35 PM", false),
  ChatBubble("I heard u guys launching new product?","4:35 PM", true),
  ChatBubble("Yes, It calls UiHunt","4:35 PM", false),
  ChatBubble("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout 😍","4:35 PM", true),
];