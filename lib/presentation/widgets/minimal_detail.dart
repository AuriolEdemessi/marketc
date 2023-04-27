import 'package:marketscc/data/models/trx_model.dart';
import 'package:marketscc/export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MinimalDetail extends StatelessWidget {
  const MinimalDetail({
    Key? key,
    this.keyValue,
    this.closeKeyValue,
    required this.trx
  }) : super(key: key);

  final String? keyValue;
  final String? closeKeyValue;
  final TrxModel? trx;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,),
      padding: const EdgeInsets.only(top: 10),
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text("Détails de la transaction", style: kHeading4.copyWith(fontWeight: FontWeight.w700),),
           Spacer(),
            Expanded(
              child: UnconstrainedBox(
                child: SizedBox(
                  height: 36.0,
                  width: 36.0,
                  child: TextButton(
                    key: Key(closeKeyValue ?? '-'),
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor:
                      Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(1000.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],),
          Container( child: DataTable(
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
            rows:  <DataRow>[
              DataRow(
                cells: <DataCell>[
                   DataCell(Text('${trx?.date}')),
                  DataCell(Container(padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5), decoration: BoxDecoration(borderRadius:BorderRadius.circular(5.0) , color: AppColors.error), child: Text('DÉCLINÉ', style: kSubtitle1.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),),)),
                   DataCell(Padding(padding: EdgeInsets.only(right: 200), child: Text('BUY${trx?.id}'),)),
                ],
              ),
            ],
          ),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl:"${trx?.paymentProof}",
                      placeholder: (context, url) => Center(child: AppLoadingIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
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
                              Text(
                                'Transaction Type : ',
                              ),
                              SpaceWidth(10),
                              Text(
                                'Achat',
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
                              Text(
                                'Quantité: ',
                              ),
                              SpaceWidth(10),
                              Text(''
                               /* '${trx?.qGet} "newAchatKey" ${trx?.currencyAcronym}',*/
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
                              Text(
                                'Montant à payer: ', // ou montant a recevoir
                              ),
                            ],),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child:  Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text("${trx?.qGive} newKeyVente acroVente", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),),
                            ),
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
