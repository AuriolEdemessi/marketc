import 'package:marketscc/data/models/trx_model.dart';
import 'package:marketscc/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailMesAnnonce extends StatelessWidget {
  const DetailMesAnnonce({
    Key? key,
    this.keyValue,
    this.closeKeyValue,
    required this.annonce
  }) : super(key: key);

  final String? keyValue;
  final String? closeKeyValue;
  final MesAnnonceModel? annonce;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,),
      padding: const EdgeInsets.only(top: 10),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Détails de l'annonce", style: kHeading4.copyWith(fontWeight: FontWeight.w700),),
          Center(
            child: DataTable(
              showCheckboxColumn: false,
              // horizontalMargin: 10.0,
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
              rows:  <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('${DateFormat.yMMMd("fr").format(DateTime.parse(annonce!.createdAt.toString()))}')),
                    DataCell(Container(padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5), decoration: BoxDecoration(borderRadius:BorderRadius.circular(5.0) , color: annonce!.etat=='1'? AppColors.lightGreen: AppColors.error), child: Text(annonce!.etat=='1'?'Activé':'Désativé', style: kSubtitle1.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),),)),
                    DataCell(Text('VENTE${annonce?.id}')),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0, left: 10),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Expanded(
                            flex: 4,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('Transaction Type : ',),
                              SpaceWidth(10),
                              Text(
                                'Vente',
                              )
                            ],),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('Quantité: ',),
                              SpaceWidth(10),
                              Text('${annonce?.reserve} BASIC ${annonce?.giveCurrencyAcronym} '
                                /*'${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
                              )
                            ],),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('Donner: ',),
                              SpaceWidth(10),
                              Text('${double.parse("${annonce?.qgive}").toStringAsFixed(2)} ${annonce?.giveCurrencyAcronym}'
                                /*'${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
                              )
                            ],),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('Recevoir: ',),
                              SpaceWidth(10),
                              Text('${double.parse("${annonce?.qget}").toStringAsFixed(2)} ${annonce?.getCurrencyAcronym}'
                                /*'${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
                              )
                            ],),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
