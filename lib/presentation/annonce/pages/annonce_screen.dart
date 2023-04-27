import 'package:marketscc/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../export.dart';

class AnnonceScreen extends StatefulWidget {
  const AnnonceScreen({
    Key? key,
  }) : super(key: key);

  @override
  AnnonceScreenState createState() => AnnonceScreenState();
}

class AnnonceScreenState extends State<AnnonceScreen> {
  static const _pageSize = 1;

  final PagingController<int, AnnonceModel> _pagingController = PagingController(firstPageKey: 1);

  late UserModel userModel;
  CurrencyExchange? selectCurrencyExchange;
  int _getId =0;
  int _giveId =0;

  var list1 =[CurrencyExchange(currencyTypeId: 0, currencyTypeName: "All", currencyName: "All")];


  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    userModel=context.read<ProfilCubit>().getUser!;

  }

  Future<void> _fetchPage(int pageKey) async {
    try {
     // List<AnnonceModel> newItems = [];
       final newItems = await context.read<AnnonceCubit>().fetch(page:pageKey, getId: _getId, giveId: _giveId);
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
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
    ),
    child: Column(children: [
      BlocConsumer<AnnonceCubit, AnnonceState>( listener: (context, state){

      }, builder: (context, state){
        if(state.deviseListStatus.isSubmissionSuccess){

           List<CurrencyExchange> newList = new List.from(list1)..addAll(state.deviseList!);


          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8),
            child: Column(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donner",
                    style: kSubtitle1,
                  ),
                  const SpaceHeight(5),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColors.grey)),
                    child: DropdownButtonFormField<CurrencyExchange>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        //fillColor: Colors.grey[300],
                      ),
                      hint: Text('All'),
                      isExpanded: true,
                      isDense: true,
                      value: selectCurrencyExchange,
                      selectedItemBuilder: (BuildContext context) {
                        return newList.map<Widget>((CurrencyExchange? item) {
                          return DropdownMenuItem(value: item, child: Text("${item?.currencyName}"));
                        }).toList();
                      },
                      items: newList.map((CurrencyExchange item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text("${item.currencyName}"),
                        );
                      }).toList(),
                      onChanged:(value){
                        _updateGiveId(giveId: value?.currenciesId??0);
                       // selectCurrencyExchange = value;
                        setState(() {
                        });
                      },
                    ),
                  ),
                ],),
              SpaceHeight(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recevoir",
                    style: kSubtitle1,
                  ),
                  const SpaceHeight(5),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColors.grey)),
                    child: DropdownButtonFormField<CurrencyExchange>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        //fillColor: Colors.grey[300],
                      ),
                      hint: Text('All'),
                      isExpanded: true,
                      isDense: true,
                      value: selectCurrencyExchange,
                      selectedItemBuilder: (BuildContext context) {
                        return newList.map<Widget>((CurrencyExchange? item) {
                          return DropdownMenuItem(value: item, child: Text("${item?.currencyName}"));
                        }).toList();
                      },
                      items: newList.map((CurrencyExchange item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text("${item.currencyName}"),
                        );
                      }).toList(),
                      onChanged:(value){
                        _updateGetId(getId: value?.currenciesId??0);
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],),
              SpaceHeight(10),
              /*ButtonWidget(
                  width: 200,
                  height: 40,
                  background: AppColors.primary,
                  textColor: AppColors.white,
                  text: "Trouver meilleur taux",
                  voidCallback: () {

                  })*/
            ],),
          );
        }else{
          return Container();
        }
      },),
      Expanded(child: PagedListView<int, AnnonceModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<AnnonceModel>(
          newPageProgressIndicatorBuilder: (context)=>Center(child: AppLoadingIndicator()),
          animateTransitions: true,
          newPageErrorIndicatorBuilder: (context){
            return Text("newPageErrorIndicator");
          },
          firstPageErrorIndicatorBuilder: (_) => FirstPageError(message: "oups,"),
          firstPageProgressIndicatorBuilder: (_) => Center(child: AppLoadingIndicator()),
          noItemsFoundIndicatorBuilder: (_) => Padding(padding: EdgeInsets.symmetric(vertical: Get.height*0.25),
            child: Column(children: [
              Text("Aucune annonces en ligne.")
            ],),),
          //   noMoreItemsIndicatorBuilder: (_) => Text("get more"),
          itemBuilder: (context, item, index) => AnnonceIterm(
            annonce: item,
            //userModel:  userModel,
          ),
        ),
        //separatorBuilder: (context, index) => SpaceHeight(10),
      ))
    ],),
  );

  void _updateGetId({required int getId}) {
    _getId = getId;
    _pagingController.refresh();
  //  _pagingController.notifyListeners();
  }

  void _updateGiveId({required int giveId}) {
    _giveId = giveId;
    _pagingController.itemList=[];
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
