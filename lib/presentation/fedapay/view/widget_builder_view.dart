import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketscc/export.dart';
import 'package:marketscc/presentation/fedapay/view/view.part.dart';
import 'package:stacked/stacked.dart';
import 'widget_builder_view_model.dart';
import 'dart:io';


class WebViewPay extends StatefulWidget {

  final TransactionApi transactionApi;
  final Function(Map<String, dynamic>, BuildContext) callback;

  const WebViewPay({
    Key? key,
    required this.transactionApi ,
    required this.callback ,
  }) : super(key: key);

  @override
  _WebViewPayState createState() => _WebViewPayState(
    this.transactionApi ,
    this.callback
  );

}



class _WebViewPayState extends State<WebViewPay> with SingleTickerProviderStateMixin {

  final TransactionApi transactionApi;
  final Function(Map<String, dynamic>, BuildContext) callback;

  _WebViewPayState(
      this.transactionApi,
      this.callback,
  );


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetBuilderViewModel>.reactive(
      onModelReady: (model) {
        Platform.isIOS ? null : SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light
        ));
      },
      builder: (context, model, child) =>  Scaffold(
        backgroundColor: AppColors.primary,
        /// Show AppBar on IOS
        appBar: Platform.isIOS ? AppBar(
          backgroundColor: AppColors.primary,
        ) : null,
        body:  Stack(
          children: [
            Container (
              margin:  Platform.isIOS ? null : EdgeInsets.only( top: MediaQuery.of(context).viewPadding.top),
              child: model.hide ? null : WidgetBuild (
                  transactionApi: transactionApi,
                 callback: callback,
              ),
            ),
            SizedBox(
              child: model.onLoading ? LoadingView() : null,
            )
          ],
        )
      ),
      viewModelBuilder: () => WidgetBuilderViewModel(),
    );
  }



}
