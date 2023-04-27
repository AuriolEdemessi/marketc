import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/data/models/user_model.dart';
import 'package:marketscc/export.dart';

import '../../fedapay/view/widget_builder_view.dart';

class EbuyPayScreen extends StatefulWidget {
  const EbuyPayScreen({Key? key, required this.buyCoinResponse})
      : super(key: key);
  final BuyCoinResponse buyCoinResponse;

  @override
  State<EbuyPayScreen> createState() => _EbuyPayScreenState();
}

class _EbuyPayScreenState extends State<EbuyPayScreen> {
  late UserModel user;

  @override
  void initState() {
    user = context.read<ProfilCubit>().getUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LISEZ AVANT DE PAYER SUR NOTRE COMPTE",
              style: kHeading1.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SpaceHeight(10),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Votre ID de transaction ou numéro de commande est : ",
                  style: kSubtitle2.copyWith(fontSize: 18)),
              TextSpan(
                  text: "${widget.buyCoinResponse.buyCoin?.trxId}",
                  style: kSubtitle2.copyWith(
                      color: AppColors.error, fontSize: 18)),
              WidgetSpan(
                baseline: TextBaseline.ideographic,
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  transform: Matrix4.translationValues(-14, 2, 0),
                  child: IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(
                            "${context.read<ProfilCubit>().getUser!.username}"
                                " ${widget.buyCoinResponse.buyCoin?.trxId}")
                            .then((value) {
                          buildWhitePopUpMessage(message: "copie");
                        });
                      },
                      icon: Icon(Icons.copy)),
                ),
              ),
            ])),
            Text(
                "Ne payez pas en dessous du montant : ${widget.buyCoinResponse.buyCoin?.qteToPay} ${widget.buyCoinResponse.buyCoin?.paymentWallet?.currency?.currencyAcronym} .",
                style: kSubtitle2.copyWith(fontSize: 18)),
            SpaceHeight(10),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text:
                  "Pour tout paiement manuel, afin d'éviter toute confusion, nous vous conseillons de choisir votre username ou l'ID de la transaction comme motif. Dans votre cas, mettez comme motif « ",
                  style: kSubtitle2.copyWith(fontSize: 18)),
              TextSpan(
                  text:
                  " ${user.username} ${widget.buyCoinResponse.buyCoin?.trxId}",
                  style: kSubtitle2.copyWith(
                      color: AppColors.error, fontSize: 18)),
              TextSpan(
                  text: " » comme motif de la transaction du dépôt. ",
                  style: kSubtitle2.copyWith(fontSize: 18)),
            ])),
            SpaceHeight(10),
            Text.rich(
              TextSpan(
                style: kSubtitle1,
                children: [
                  TextSpan(
                      text: 'En procédant au paiement,',
                      style: kSubtitle2.copyWith(fontSize: 18)),
                  TextSpan(
                    text: ' vous acceptez ces conditions ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => dialogBuilder(context),
                    style: kSubtitle2.copyWith(
                        color: AppColors.error, fontSize: 18),
                  ),
                  TextSpan(
                    text: 'de Marketscc.',
                    style: kSubtitle2.copyWith(fontSize: 18),
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informations pour le paiement Adresse de paiement :",
                    style: kSubtitle2.copyWith(fontSize: 18)),
                SpaceHeight(10),
                Text(
                    "PAIEMENT VIA ${widget.buyCoinResponse.buyCoin?.paymentApiWay?.apiName == "Aucun" ? widget.buyCoinResponse.buyCoin?.paymentWallet?.currency?.currencyName : " API"}",
                    style: kSubtitle2.copyWith(fontSize: 18)),
                Visibility(
                    visible: widget.buyCoinResponse.buyCoin?.paymentWallet
                        ?.address ==
                        null
                        ? false
                        : true,
                    child: Column(
                      children: [
                        SpaceHeight(10),
                        Row(
                          children: [
                            Text(
                                "${widget.buyCoinResponse.buyCoin?.paymentWallet?.address}",
                                style: kSubtitle2.copyWith(fontSize: 18)),
                            IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy("${widget.buyCoinResponse.buyCoin?.paymentWallet?.address}")
                                      .then((value) {
                                    buildWhitePopUpMessage(message: "copie");
                                  });
                                },
                                icon: Icon(Icons.copy))
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            SpaceHeight(20),
            Text("Montant à payer", style: kSubtitle2.copyWith(fontSize: 18)),
            SpaceHeight(10),
            Text(
                "${widget.buyCoinResponse.buyCoin?.qteToPay} Par ${widget.buyCoinResponse.buyCoin?.paymentWallet?.currency?.currencyName}",
                style: kSubtitle2.copyWith(fontSize: 18)),
            SpaceHeight(20),
            Text("Ce que vous obtenez",
                style: kSubtitle2.copyWith(fontSize: 18)),
            SpaceHeight(10),
            Text(
                "${widget.buyCoinResponse.buyCoin?.qteToGet} ${widget.buyCoinResponse.buyCoin?.receiverWallet?.currency?.currencyAcronym}",
                style: kSubtitle2.copyWith(fontSize: 18)),
            SpaceHeight(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Portefeuille ${widget.buyCoinResponse.buyCoin?.receiverWallet?.currency?.currencyName} du receveur",
                    style: kSubtitle2.copyWith(fontSize: 18)),
                SpaceHeight(10),
                Text(
                    "${widget.buyCoinResponse.buyCoin?.receiverWallet?.address}",
                    style: kSubtitle2.copyWith(fontSize: 18)),
              ],
            ),
            SpaceHeight(20),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<ExchangeCubit>().resetStatut();
                        context
                            .read<AppMenuCubit>()
                            .setNavBarItem(AppMenuItem.home);
                        Get.offAll(DashboardScreen());
                        //  Get.toNamed(RoutePaths.proofScreen, arguments: widget.buyCoinResponse);
                      },
                      child: ButtonWidget(
                        background:AppColors.white,
                        textColor: AppColors.black,
                        borderColor: AppColors.primary,
                        text: "Retour à  l'accueil",
                      )
                    )),
                SpaceWidth(15),
                Expanded(child:  BlocConsumer<FedapayCubit, FedapayState>(
                    listener: (context, state){
                      if(state.createTransactionStatus.isSubmissionInProgress){
                        openLoadingDialog();
                      }else if(state.createTransactionStatus.isSubmissionFailure){
                        Get.back();

                      }else if(state.createTransactionStatus.isSubmissionSuccess){
                        Get.back();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebViewPay(
                            transactionApi: state.transactionApi!,
                            callback: successCallback,
                          )),
                        );
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                          onTap: () {
                            if(widget.buyCoinResponse.buyCoin!.paymentApiWay!.id==0){
                              context.read<ExchangeCubit>().resetStatut();
                              Get.offNamed(RoutePaths.proofScreen,
                                  arguments: BuyInfo(
                                    trxId: widget.buyCoinResponse.buyCoin!.trxId!,
                                    address: "${widget.buyCoinResponse.buyCoin?.paymentWallet?.address}",
                                    currencyName: "${widget.buyCoinResponse.buyCoin?.paymentWallet?.currency?.currencyName}",
                                    back: false,
                                  ));
                            }else if(widget.buyCoinResponse.buyCoin!.paymentApiWay!.id==1){
                              //todo cache cap
                              context.read<ExchangeCubit>().resetStatut();
                              buildWhitePopUpMessage(message: "Methode de paiement non supporter actuellement");
                            }else if(widget.buyCoinResponse.buyCoin!.paymentApiWay!.id==2){
                              context.read<ExchangeCubit>().resetStatut();
                              UserModel user= context.read<ProfilCubit>().getUser!;
                              context.read<FedapayCubit>().getUrlTransaction(
                                  userId: user.userId!,
                                  trxId: int.parse(widget.buyCoinResponse.buyCoin!.trxId!)
                              );
                            }else{
                              context.read<ExchangeCubit>().resetStatut();
                              buildWhitePopUpMessage(message: "Methode de paiement non supporter actuellement");
                            }

                          },
                          child: ButtonWidget(
                            background:AppColors.primary,
                            textColor: AppColors.white,
                            text: "Confirmer le paiement",
                          )
                      );
                    })),
              ],
            ),
            SpaceHeight(20),
          ],
        ),
      ),
    ),);
  }
}
