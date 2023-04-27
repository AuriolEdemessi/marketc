import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marketscc/presentation/widgets/image_container.dart';

import '../../../export.dart';

class ListeMesAnnonces extends StatefulWidget {
  const ListeMesAnnonces({Key? key}) : super(key: key);

  @override
  State<ListeMesAnnonces> createState() => _ListeMesAnnoncesState();
}

class _ListeMesAnnoncesState extends State<ListeMesAnnonces> {
  static const _pageSize = 1;

  final PagingController<int, MesAnnonceModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PurchaseCubit>().fetchPurchaseList();
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });



  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context.read<MesAnnoncesCubit>().fetch(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = ++pageKey ;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Historique de mes annonces',
          style: kHeading2.copyWith(fontSize: 15),
        ),
      ),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
          ),
          child: PagedListView<int, MesAnnonceModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<MesAnnonceModel>(
                newPageProgressIndicatorBuilder: (context)=>Center(child: AppLoadingIndicator()),
                animateTransitions: true,
                newPageErrorIndicatorBuilder: (context){
                  return Text("newPageErrorIndicator");
                },
                firstPageErrorIndicatorBuilder: (_) => FirstPageError(message: "oups, error"),
                firstPageProgressIndicatorBuilder: (_) => Center(child: AppLoadingIndicator()),
                noItemsFoundIndicatorBuilder: (_) => NoIterm(text: "Vous n'avez aucune annonce en ligne.",),
                //   noMoreItemsIndicatorBuilder: (_) => Text("get more"),
                itemBuilder: (context, item, index) =>  InkWell(
                  onTap: ()=>showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return DetailMesAnnonce(
                        annonce: item,
                      );
                    },
                  ),
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right: 5
                            ),
                            child:ImageContainer(url: "${item.giveCurrenciesImage}")
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("Réserve"),
                            Text("${item.reserve}"),
                            Text("${item.giveCurrenciesName}"),
                          ],),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Donner"),
                              Text("${double.parse("${item.qgive}").toStringAsFixed(2)}"),
                              Text("${item.giveCurrencyAcronym}"),
                             // Text("${item.}"),
                            ],),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recevoir"),
                              Text("${item.qget}"),
                              Text("${item.getCurrencyAcronym}"),
                            ],),
                          Column(children: [
                            InkWell(
                              onTap: (){
                                Get.toNamed(RoutePaths.editAnnonce, arguments: item)?.then((_){
                                  _pagingController.refresh();
                                });

                                //Get.toNamed(RoutePaths.editAnnonce, arguments: item);
                              },
                              child: Container(
                                width: 100,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color:AppColors.primary1, width: 0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(RadiusSizes.r5))),
                                child: Text("Editer"),
                              ),
                            ),
                            SpaceHeight(10),

                            BlocConsumer<AnnonceCubit, AnnonceState>(
                              listener: (context, state){
                                if (state.deleteAnnonceStatus.isSubmissionFailure) {
                                  Get.back();
                                  String message = "";
                                  state.message?.errors?.forEach((element) {
                                    message += "$element\n";
                                  });
                                  buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);
                                }else if(state.deleteAnnonceStatus.isSubmissionSuccess){
                                  Get.back();
                                  buildWhitePopUpMessage(message: "${state.sucessMessage?.message}");
                                  _pagingController.refresh();
                                }else if(state.deleteAnnonceStatus.isSubmissionInProgress){
                                  openLoadingDialog();
                                }
                              },
                              builder: (context, state){
                                return InkWell(onTap: (){
                                  customAlertDialog(
                                    child: Text("Voulez vous supprimer l'annonce?", style: kSubtitle1,),
                                      yesAction: (){
                                        Get.back();
                                         context.read<AnnonceCubit>().deleteAnnonceById(item.trId);
                                  },
                                    noAction: (){
                                    Get.back();
                                    }
                                  );
                                }, child: Container(
                                  width: 100,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color:AppColors.error, width: 0.5),
                                      borderRadius: const BorderRadius.all(Radius.circular(RadiusSizes.r5))),
                                  child: Text("Supprimer",
                                    style: kSubtitle2.copyWith(
                                        color: AppColors.primary),
                                  ),
                                ),);
                              },
                            ),

                          ],)
                          ,
                        ],
                      )
                    )
                  ),
                )
            ),
          ),
        ),
      ),
    ],
  );
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
