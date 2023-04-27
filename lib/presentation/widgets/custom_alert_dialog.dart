import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/export.dart';

Future<dynamic> customAlertDialog({
  required VoidCallback yesAction,
   String? yesText,
   String? noText,
  required VoidCallback noAction,
  required Widget child,

}) async {
  return await Get.dialog(
      //barrierDismissible: true,
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
       // backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpaceHeight(20),
            child,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    noAction.call();
                  },
                  child:  Text(noText??'non'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    yesAction.call();
                  },
                  child: Text(yesText??'Oui'),
                ),
              ],
            )
          ],
        ),
      ));
}
