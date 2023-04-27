import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoIterm extends StatelessWidget {
  const NoIterm({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: Get.height*0.4),
    child: Column(children: [
      Text(text)
      //Text("Aucune donnée disponible actuellement")
    ],),);
  }
}
