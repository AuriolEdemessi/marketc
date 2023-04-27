import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

class ResumeExchange extends StatefulWidget {
  const ResumeExchange({Key? key, required this.exchangeBuyCoin})
      : super(key: key);

  final ExchangeBuyCoin exchangeBuyCoin;

  @override
  State<ResumeExchange> createState() => _ResumeExchangeState();
}

class _ResumeExchangeState extends State<ResumeExchange> {
  bool isStepTwo = false;

  bool shouldPop = false;

  DateTime lastTimeBackbuttonWasClicked = DateTime.now();

  late BuyCoinResponse buyCoinResponse;

  @override
  Widget build(BuildContext context) {
    return /*WillPopScope(
      onWillPop: () async {
        customAlertDialog(
            title: "Voulez vous retourner à l'accueil",
            yesAction: () {
              if (isStepTwo) {
                try {
                  //context.read<HomeCubit>().deleteTransaction(buyCoinResponse.buyCoin!.trxId!);
                  context.read<ExchangeCubit>().resetStatut();
                  context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.home);
                  setState(() {
                    shouldPop = true;
                  });
                  Get.offAllNamed(RoutePaths.dashboardScreen);
                } catch (e) {
                  log("$e");
                }
              } else {
                setState(() {
                  shouldPop = true;
                });
                Get.offAllNamed(RoutePaths.dashboardScreen);
                Get.back();
                Get.back();
              }
            },
            noAction: () {
              setState(() {
                shouldPop = false;
              });
              Get.back();
            });
        return shouldPop;
      },
      child:*/ Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: AppColors.white,
        body: BlocConsumer<ExchangeCubit, ExchangeState>(
          listener: (context, state) {
            if (state.buyCoinStatus.isSubmissionFailure) {
              String message = "";
              state.message?.errors?.forEach((element) {
                message += "$element\n";
              });
              buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);
            }else if(state.buyCoinStatus.isSubmissionSuccess){
              Get.offNamed(RoutePaths.ebuyPayScreen, arguments: state.buyCoinResponse!);
             // Get.to(()=>EbuyPayScreen(buyCoinResponse: state.buyCoinResponse!,),);
            }
          },
          builder: (context, state) {
           /* if (state.buyCoinStatus.isSubmissionFailure){
              WidgetsBinding.instance.addPostFrameCallback((_){
                String message = "";
                state.message?.errors?.forEach((element) {
                  message += "$element\n";
                });
                buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);

              });

            }else if (state.buyCoinStatus.isSubmissionSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_){
              });
            }*/

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0)
                    .copyWith(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Résumé de la transaction",
                      style: kHeading1.copyWith(fontSize: 25),
                    ),
                    SpaceHeight(10),
                    Text(
                      "Retrouvez ci-dessous le résumé de votre achat ${widget.exchangeBuyCoin.annonceModel?.giveSymbol}. Cryptocurrency Markets ne sera pas responsable de toute perte résultant d’une mauvaise adresse de portefeuille ou d’une réduction du taux ou du prix de cette device : ${widget.exchangeBuyCoin.annonceModel?.giveSymbol}",
                      style: kSubtitle1,
                    ),
                    SpaceHeight(20),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text:
                                "Vous pouvez annuler cette opération en cliquant",
                            style: kHeading4),
                        TextSpan(
                          text: " ici.",
                          style: kHeading4.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              context
                                  .read<AppMenuCubit>()
                                  .setNavBarItem(AppMenuItem.home);
                              Get.offAll(DashboardScreen());
                            },
                        )
                      ]),
                    ),
                    SpaceHeight(20),
                    Text(
                      "Résumé des devises",
                      style: kHeading4,
                    ),
                    SpaceHeight(20),
                    Text("Montant total à payer"),
                    SpaceHeight(20),
                    Text(
                        "${widget.exchangeBuyCoin.quantityToExchange} Par ${widget.exchangeBuyCoin.annonceModel?.getSymbol}"),
                    SpaceHeight(20),
                    Center(
                      child: state.buyCoinStatus.isSubmissionInProgress
                          ? Container(
                              child: AppLoadingIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                // Get.toNamed(RoutePaths.ebuyPayScreen);
                                context.read<ExchangeCubit>().buyCoin(
                                    annonceId: widget.exchangeBuyCoin.trId,
                                    quantity: widget
                                        .exchangeBuyCoin.quantityToExchange,
                                    text: widget.exchangeBuyCoin.text);
                              },
                              child: ButtonWidget(
                                background:AppColors.primary,
                                textColor: AppColors.white,
                                text: "Procéder au paiement",
                              )
                            ),
                    )
                  ],
                ),
              ),
            );

            /*if(state.buyCoinStatus.isSubmissionSuccess){
              WidgetsBinding.instance.addPostFrameCallback((_){
                setState(() {
                  isStepTwo = true;
                  buyCoinResponse = state.buyCoinResponse!;
                });
              });
              return  EbuyPayScreen( buyCoinResponse: state.buyCoinResponse!);
              //

            }*/
          },
        ),
     // ),
    );
  }
}
