import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marketscc/presentation/widgets/image_container.dart';

import '../../../../data/models/trx_model.dart';
import '../../../../export.dart';

class SalesTransactionScreen extends StatefulWidget {
  const SalesTransactionScreen({
    Key? key,
  }) : super(key: key);

  @override
  SalesTransactionScreenState createState() => SalesTransactionScreenState();
}

class SalesTransactionScreenState extends State<SalesTransactionScreen> {
  static const _pageSize = 1;

  final PagingController<int, TrxModel> _pagingController = PagingController(firstPageKey: 1);


  @override
  void initState() {

    Future.microtask(() {
      context.read<SalesCubit>().fetchSalesList();
    });

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context.read<SalesCubit>().fetchSales(pageKey);
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

  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Historique de mes ventes',
          style: kHeading2.copyWith(fontSize: 15),
        ),
      ),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
          ),
          child: PagedListView<int, TrxModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<TrxModel>(
              newPageProgressIndicatorBuilder: (context)=>Center(child: AppLoadingIndicator()),
              animateTransitions: true,
              newPageErrorIndicatorBuilder: (context){
                return Text("newPageErrorIndicator");
              },
              firstPageErrorIndicatorBuilder: (_) => FirstPageError(message: "oups, error"),
              firstPageProgressIndicatorBuilder: (_) => Center(child: AppLoadingIndicator()),
              noItemsFoundIndicatorBuilder: (_) => NoIterm(text: "Aucune vente effectuée.",),
              //   noMoreItemsIndicatorBuilder: (_) => Text("get more"),
              itemBuilder: (context, item, index) => InkWell(
                onTap: ()=>showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return MinimalDetailSales(
                      trx: item,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: 5
                              ),
                              child: ImageContainer(url: "${item.currencyGiveImage}",)  //Image.asset("assets/images/bitcoin.png", height: 25, width: 25,),
                            ),
                            Text("${item.currencyGiveName}"),
                            SpaceWidth(5),
                            statusByUi(item.status!)
                          ],
                        ),
                        SpaceHeight(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vente"),
                              SpaceHeight(10),
                              Text("Recevoir"),
                              SpaceHeight(10),
                              Text("Mode paiement"),
                            ],),),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${double.parse(item.qGive!).toStringAsFixed(2)}" " ${item.currencyGiveBasic} " "${item.currencyGiveAcronym}"),
                              SpaceHeight(10),
                              Text("${double.parse(item.qGet!).toStringAsFixed(2)}" " ${item.currencyGetBasic} " "${item.currencyGetAcronym}"),
                              SpaceHeight(10),
                              Text("${item.currencyGiveApi == 0 ? "${item.currencyGetAcronym}" : "Via API"}"),
                            ],)),
                        ],),
                        // SpaceHeight(10),
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    ],
  );
}
