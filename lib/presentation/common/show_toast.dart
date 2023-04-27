import 'package:flutter/material.dart';
import 'package:marketscc/presentation/common/notification.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as fts;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

import '../../export.dart';

showToast(scaffoldMessengerKey, message) {
  ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          content: NotificationWidget(
            message: message,
          )));
}


buildWhitePopUpMessage({
  required String message,
  TextStyle? style,
  EdgeInsets? padding,
  StyledToastAnimation? animation,
  StyledToastAnimation? reverseAnimation,
  StyledToastPosition? position,
  Curve? curve,
  Curve? reverseCurve,
  double? radius,
  Duration? duration,
  Duration? animDuration,
}) {
  fts.showToastWidget(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 16),
        color: Colors.white,
      ),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: padding ?? const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
    context: Get.overlayContext!,
    //position: position ?? StyledToastPosition.center,
    //animation: animation ?? StyledToastAnimation.scale,
    //reverseAnimation: reverseAnimation ?? StyledToastAnimation.fade,
    //duration: duration ?? const Duration(seconds: 2),
    //animDuration: animDuration ?? const Duration(seconds: 1),
   // curve: curve ?? Curves.elasticOut,
    //reverseCurve: reverseCurve ?? Curves.linear,

  );
}

