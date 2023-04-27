import 'package:get/get.dart';
import 'package:marketscc/export.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({Key? key, this.value, this.color}) : super(key: key);
  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
          value: value,
          strokeWidth: 1.0,
        ),
      );
  }
}


Future<void> openLoadingDialog() async {
  Get.dialog(
      //barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child:  Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color:AppColors.primary1,
            ),
          ),
        ),
      ));
}
