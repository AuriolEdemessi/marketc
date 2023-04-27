import 'package:get/get.dart';
import 'package:marketscc/data/models/user_model.dart';
import 'package:marketscc/export.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class ListeMesWallet extends StatelessWidget {
  const ListeMesWallet({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<ProfilCubit>().getUser!;
    return BlocConsumer<PortefeuillesCubit, PortefeuillesState>(
      listener: (context, state){
        if(state.deteleWalletStatus.isSubmissionInProgress){
        }else if(state.deteleWalletStatus.isSubmissionSuccess){
          buildWhitePopUpMessage(message: "${state.updateMessage}");
          context.read<PortefeuillesCubit>().reset();
          context.read<ProfilCubit>().setUserData(state.user!);
          context.read<PortefeuillesCubit>().reset();
        }else if(state.deteleWalletStatus.isSubmissionFailure){
          buildWhitePopUpMessage(message: "${state.message?.release}");
          context.read<PortefeuillesCubit>().reset();
        }
      },
      builder: (context, state){
      return state.deteleWalletStatus.isSubmissionInProgress?Center(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 58.0),
        child: AppLoadingIndicator(),
      ),): SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
           // horizontalMargin: 0,
            columnSpacing: 45,
            //headingRowHeight: 0,
            columns: [
              DataColumn(
                label: Text('Portefeuille'),
              ),
              DataColumn(
                label: Text('Adresse enregirstré'),
              ),
              DataColumn(
                label: Text('Delete'),
              )
            ],
            rows: userModel.wallet!.map(
                  (wallet) => DataRow(cells:
              [
                DataCell(
                  Text(
                    '${wallet.currency?.acronym}',
                  ),
                  onTap: () {

                  },
                ),
                DataCell(
                  Text(
                    StrFormater.ellipsisCenter('${wallet.address}'),
                  ),
                  onTap: () {

                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    customAlertDialog(
                        child: Text("Souhaitez vous supprimer l\'adresse ?", style: kSubtitle1,),
                        yesAction: (){
                          Get.back();
                          context.read<PortefeuillesCubit>().deleteWalletById(wallet.id);
                        },
                        noAction: (){
                          Get.back();
                        }
                    );

                  },
                ))
              ]
              ),
            ).toList(),
          ),
        ),
      );
      },

    );
  }
}
