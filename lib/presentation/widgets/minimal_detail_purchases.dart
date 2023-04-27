import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketscc/data/models/trx_model.dart';
import 'package:marketscc/export.dart';
import 'package:marketscc/presentation/payment/page/payment_page.dart';
import 'package:marketscc/presentation/widgets/successScreen.dart';

import '../../data/models/payment_api.dart';
import '../../data/models/user_model.dart';
import '../fedapay/view/widget_builder_view.dart';
import '../zoom/zoom_page.dart';

void successCallback(response, context) {
  Navigator.pop(context);
  Get.off(PaymentPage(idTransaction: response['transactionId']));
}

class MinimalDetailPurchases extends StatelessWidget {
  const MinimalDetailPurchases(
      {Key? key, this.keyValue, this.closeKeyValue, required this.trx})
      : super(key: key);

  final String? keyValue;
  final String? closeKeyValue;
  final TrxModel? trx;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
      ),
      padding: const EdgeInsets.only(top: 10),
      height: Get.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Détails de la transaction",
            style: kHeading4.copyWith(fontWeight: FontWeight.w700),
          ),
          DataTable(
            showCheckboxColumn: false,
            horizontalMargin: 10.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Date',
                ),
              ),
              DataColumn(
                label: Text(
                  'Statut',
                ),
              ),
              DataColumn(
                label: Text(
                  'Code ID',
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                      '${DateFormat.yMMMd("fr").format(DateTime.parse(trx!.date.toString()))}')),
                  DataCell(statusUi(
                    trx!.status!,
                  )),
                  //  DataCell(Container(padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5), decoration: BoxDecoration(borderRadius:BorderRadius.circular(5.0) , color: AppColors.error), child: Text('DÉCLINÉ', style: kSubtitle1.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),),)),
                  DataCell(Text('BUY${trx?.id}')),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TRANSACTION INFO",
                  style: kHeading4.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w700),
                ),
                SpaceHeight(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction Type : ',
                          ),
                          SpaceWidth(10),
                          Text(
                            '${trx?.trxType}',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SpaceHeight(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payer: ', // ou montant a recevoir
                          ),
                          Text(
                              '${trx?.qGive} ${trx?.currencyGiveBasic} ${trx?.currencyGiveAcronym}'),
                        ],
                      ),
                    ),
                  ],
                ),
                SpaceHeight(5),
                Text(
                  "DÉTAILS DE LA DEVISE ACHETÉ",
                  style: kHeading4.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w700),
                ),
                SpaceHeight(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recevoir: ',
                          ),
                          SpaceWidth(10),
                          Text(
                              '${double.parse(trx!.qGet!).toStringAsFixed(2)} ${trx?.currencyGetAcronym}'
                              /*'${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
                              )
                        ],
                      ),
                    ),
                  ],
                ),
                SpaceHeight(5),
                SpaceHeight(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adresse :', // ou montant a recevoir
                          ),
                          trx!.trxType=="ACHAT"?  Text(StrFormater.ellipsisCenter('${context.read<ProfilCubit>().getUser!.wallet!.firstWhereOrNull((element) => element.currency!.id==trx!.currencyGetId!)?.address??""}')):
                          InkWell(
                            onTap: () {
                              FlutterClipboard.copy(
                                  "${trx!.currencyGiveAdress!}")
                                  .then((value) {
                                buildWhitePopUpMessage(message: "Adresse copie avec succès");
                              });
                            },
                            child: Text("${trx!.currencyGiveAdress!}"),
                          )
                          ,
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SpaceHeight(30),
          Center(
            child: proofByStatus(
                trx:trx!,
                context: context),
          )
        ],
      ),
    );
  }
}

Widget proofByStatus(
    {
     required TrxModel trx,
    required BuildContext context,
    }) {
  switch (trx.status!) {
    case "0":
      if(trx.trxType=="ACHAT"){
        if (trx.currencyGiveApi! == 0) {
          return InkWell(
              onTap: () {
               /* Get.toNamed(RoutePaths.proofScreen,
                    arguments: BuyInfo(
                        trxId: "${trx.trxId!}",
                        back: true,
                        address: "${trx.currencyGetAddress}",
                        currencyName: "${trx.currencyGetName}"
                    ));*/

                Get.toNamed(RoutePaths.proofScreen,
                    arguments: BuyInfo(
                      trxId: "${trx.trxId!}",
                      back: true,
                      address: "${trx.currencyGiveAdress}",
                      currencyName: "${trx.currencyGiveName}"
                    ));
              },
              child: ButtonWidget(
                background:AppColors.primary,
                textColor: AppColors.white,
                text: "Payer maintenant",
              )
          );
        } else {
          if(trx.currencyGiveApi==1){
            // carchap
            return Container();

          }else if(trx.currencyGiveApi==2){
            // fedapay
            return BlocConsumer<FedapayCubit, FedapayState>(
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
                        UserModel user= context.read<ProfilCubit>().getUser!;
                        context.read<FedapayCubit>().getUrlTransaction(
                            userId: user.userId!,
                            trxId: int.parse("${trx.trxId}")
                        );
                      },
                      child: ButtonWidget(
                        background:AppColors.primary,
                        textColor: AppColors.white,
                        text: "Payer maintenant",
                      )
                  );
                });

          }else{
            return Container();
          }
        }
      }else {
        return Container();
      }

    case "2":
    case "1":
      if(trx.currencyGiveApi==0){
        return InkWell(
            onTap: () {
              CustomOverlay(
                context: context,
                builder: (removeOverlay) => Material(
                  child: InkWell(
                    onTap: removeOverlay,
                    child: CachedNetworkImage(
                      imageUrl: trx.paymentProof!,
                      placeholder: (context, url) =>
                          Center(child: AppLoadingIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
            child: ButtonWidget(
              background:AppColors.primary,
              textColor: AppColors.white,
              text: "Voir la preuve",
            )
  );
      }else{
        return Container();
      }
    default:
      return Container();
  }
}

Widget statusUi(String statut) {
  switch (statut) {
    case "0":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary1, width: 0.5),
            borderRadius:
                const BorderRadius.all(Radius.circular(RadiusSizes.r5))),
        child: Text(
          'Non payé',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      );
    case "1":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: AppColors.hover),
        child: Text(
          'En attente',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      );
    case "2":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.lightGreen),
        child: Text(
          'Payé',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w700),
        ),
      );
    default:
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: AppColors.error),
        child: Text(
          'Décliné',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w700),
        ),
      );
  }
}

Widget statusByUi(String statut) {
  switch (statut) {
    case "0":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary1, width: 0.5),
            borderRadius:
                const BorderRadius.all(Radius.circular(RadiusSizes.r5))),
        child: Text(
          'Non payé',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      );
    case "1":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: AppColors.hover),
        child: Text(
          'En attente',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w700),
        ),
      );
    case "2":
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.lightGreen),
        child: Text(
          'Payé',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w700),
        ),
      );
    default:
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: AppColors.error),
        child: Text(
          'Décliné',
          textAlign: TextAlign.center,
          style: kSubtitle1.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w700),
        ),
      );
  }
}
