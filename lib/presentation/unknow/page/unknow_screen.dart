import 'package:flutter/material.dart';

class UnknowScreen extends StatefulWidget {
  const UnknowScreen({Key? key}) : super(key: key);

  @override
  State<UnknowScreen> createState() => _UnknowScreenState();
}

class _UnknowScreenState extends State<UnknowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Oups!, page not found")),
    );
  }
}
