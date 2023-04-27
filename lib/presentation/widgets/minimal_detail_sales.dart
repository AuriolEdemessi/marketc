import 'package:get/get.dart';
import 'package:marketscc/data/models/trx_model.dart';
import 'package:marketscc/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketscc/presentation/zoom/zoom_page.dart';

class MinimalDetailSales extends StatelessWidget {
  const MinimalDetailSales(
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
      height: Get.height * 0.5 - kToolbarHeight,
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
                  DataCell(statusByUi(trx!.status!)
                      //Container(padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5), decoration: BoxDecoration(borderRadius:BorderRadius.circular(5.0) , color: AppColors.error), child: Text('DÉCLINÉ', style: kSubtitle1.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),),)
                      ),
                  DataCell(Text('SALE${trx?.id}')),
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
                            'Quantité: ',
                          ),
                          SpaceWidth(10),
                          Text(
                              '${double.parse(trx!.qGive!).toStringAsFixed(2)} ${trx?.currencyGiveAcronym}'
                              /*'${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
                              )
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
                            'Recevoir: ', // ou montant a recevoir
                          ),
                          Text(
                              '${trx?.qGet} ${trx?.currencyGetBasic} ${trx?.currencyGetAcronym}'),
                        ],
                      ),
                    ),
                  ],
                ),
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
                          trx!.trxType == "ACHAT"
                              ? Text(StrFormater.ellipsisCenter(
                                  '${context.read<ProfilCubit>().getUser!.wallet!.firstWhereOrNull((element) => element.currency!.id == trx!.currencyGetId!)?.address ?? ""}'))
                              :
                              InkWell(
                                  onTap: () {
                                    FlutterClipboard.copy(
                                            "${trx!.currencyGiveAdress!}")
                                        .then((value) {
                                      buildWhitePopUpMessage(message: "Adresse copie avec succès");
                                    });
                                  },
                                  child: Text("${trx!.currencyGiveAdress!}"),
                                ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SpaceHeight(10),

          preuveUi(
              trx!.status!, trx!.currencyGetApi!, context, trx!.paymentProof)

          //Center(child: proofByStatus(statut: trx!.status!, paymentProof :trx?.paymentProof, paymentApiWay: trx?.paymentApiWay, context:context, currencyGiveApi: trx!.currencyGiveApi!, trxId:trx!.id!),)
        ],
      ),
    );
  }
}

Widget preuveUi(String statut, int currencyGiveApi, context, paymentProof) {
  switch (statut) {
    case "1":
    case "2":
      if (currencyGiveApi == 0) {
        return Center(
          child: InkWell(
              onTap: () {
                CustomOverlay(
                  context: context,
                  builder: (removeOverlay) => Material(
                    child: InkWell(
                      onTap: removeOverlay,
                      child: CachedNetworkImage(
                        imageUrl: paymentProof!,
                        placeholder: (context, url) =>
                            Center(child: AppLoadingIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 30,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.primary1),
                child: Text(
                  'Voir la preuve',
                  textAlign: TextAlign.center,
                  style: kSubtitle1.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
              )),
        );
      } else {
        return Container();
      }
    default:
      return Container();
  }
}
