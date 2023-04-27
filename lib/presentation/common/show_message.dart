import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

/*showMessage(key, context, ErrorMessage errorMessage){
  ScaffoldMessenger.of(key.currentContext!).showMaterialBanner(MaterialBanner(
    padding: EdgeInsets.all(20),
    overflowAlignment: OverflowBarAlignment.start,
    leading: Icon(Icons.info_outline, color: Colors.white),
    backgroundColor:  AppColors.primary,
    content: Text('${errorMessage.debug}', style: kSubtitle2.copyWith(color: AppColors.white),),
    actions: <Widget>[
      TextButton(
        child: Text('Done', style: kSubtitle2.copyWith(color: AppColors.white),),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
      ),
    ],
  ));
}

void showError(scaffoldMessengerKey, context, state)async{
  showMessage(scaffoldMessengerKey,context, state.message!);
  await 2.delay();
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
}*/

