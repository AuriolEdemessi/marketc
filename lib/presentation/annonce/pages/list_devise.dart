import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/presentation/widgets/image_container.dart';

import '../../../export.dart';

class ListDevisePage extends StatefulWidget {
  const ListDevisePage({Key? key}) : super(key: key);

  @override
  State<ListDevisePage> createState() => _ListDevisePageState();
}

class _ListDevisePageState extends State<ListDevisePage> {

  List<CurrencyExchange> filterList =[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnonceCubit, AnnonceState>(
      listener: (conext, state){

      },
      builder: (context, state){
        if (state.deviseListStatus.isSubmissionSuccess){

           filterList = state.deviseList!.where((element) => element.currenciesId!=18).toList();
          // filterList = state.deviseList!.where((element) => element.currenciesId!=18) as List<CurrencyExchange>;

          return LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Veillez selectionner la devise à donner ',
                    style: kHeading2.copyWith(fontSize: 15),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: filterList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){

                        Get.toNamed(RoutePaths.postAnnonce, arguments: filterList[index]);

                        //Get.toNamed(RoutePaths.exchange, arguments: state.exchangeList![index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageContainer(
                              margin: EdgeInsets.only(left: 20),
                              url: "${filterList[index].currencyImage}",
                            ),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${filterList[index].currencyName}",),
                                ],),
                            ))
                          ],
                        ),
                      ),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 26/7,
                    ),
                  ),
                ),
              ],
            );
          });
        }else if(state.deviseListStatus.isSubmissionInProgress){
          return Text("");
        }else if(state.deviseListStatus.isSubmissionFailure){
          return Center(child: AppLoadingIndicator());
        }else{
          return Center(child: AppLoadingIndicator());
        }
      }
    );
  }
}
