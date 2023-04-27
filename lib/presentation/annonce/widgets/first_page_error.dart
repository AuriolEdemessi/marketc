import 'package:flutter/material.dart';

class FirstPageError extends StatelessWidget {

  const FirstPageError({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("$message"),);
  }
}
