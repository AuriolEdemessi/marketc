import 'package:flutter/material.dart';

import '../../export.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) =>  ColoredBox(
          color: AppColors.white,
          child:Stack(
            alignment: Alignment.center,
            children: const <Widget>[
              Image(image: AppAssets.imgLogo, height: 45, width: 45,),
              SizedBox(
                height: 75.0,
                width: 75.0,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),

            ],
          ),
        ),
      );
      Overlay.of(context)?.insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }
}