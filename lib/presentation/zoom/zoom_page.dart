import 'dart:ui';

import 'package:flutter/material.dart';

class CustomOverlay {
  final BuildContext context;
  final Widget? overlayWidget;
  final Function? builder;

  late Function removeOverlay;
  late OverlayEntry overlay, overlayBackground;

  CustomOverlay({required this.context, this.overlayWidget, required this.builder}) {
    removeOverlay = () {
      overlayBackground.remove();
      overlay.remove();
    };
    overlayBackground = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          onTap: () => removeOverlay(),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
    if (overlayWidget != null)
      overlay = OverlayEntry(
        builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: overlayWidget!,)
            ]),
      );
    else
      overlay = OverlayEntry(
        builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              builder!(removeOverlay)
            ]),
      );
    buildOverlay(context);
  }

  void buildOverlay(BuildContext context) {
    Overlay.of(context)!.insertAll([overlayBackground, overlay]);
  }
}