import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../export.dart';
import '../../widgets/image_container.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const _pageSize = 1;

  final PagingController<int, MesNotificationModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context.read<NotificationCubit>().fetch(pageKey);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
        ),
        child: PagedListView<int, MesNotificationModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MesNotificationModel>(
              newPageProgressIndicatorBuilder: (context)=>Center(child: Container(margin: EdgeInsets.only(top: 10), child: AppLoadingIndicator(),)),
              animateTransitions: true,
              newPageErrorIndicatorBuilder: (context){
                return Text("newPageErrorIndicator");
              },
              firstPageErrorIndicatorBuilder: (_) => FirstPageError(message: "oups, error"),
              firstPageProgressIndicatorBuilder: (_) => Center(child: Container(margin: EdgeInsets.only(top: 10), child: AppLoadingIndicator(),)),
              noItemsFoundIndicatorBuilder: (_) => NoIterm(text: "Aucune notification disponible",),
              itemBuilder: (context, item, index) => InkWell(
                onTap: ()async{
                  await context.read<NotificationCubit>().notificationRead(item.id);
                  context.read<NotificationCubit>().unreadNotif();
                  _pagingController.refresh();
                },
                child: Container(
                  //height: 143,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: (item.status??0)==0? AppColors.boxShadow3.withOpacity(0.1):null,
                      //border: Border.all(width: 0.5, color: AppColors.grey.withOpacity(0.1)),
                      borderRadius: const BorderRadius.all(Radius.circular(RadiusSizes.r20),)),
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageContainer(url: "${item.logo}",),
                          SpaceWidth(10),
                          Expanded(
                            child: Text(
                              "${item.title}",
                              style: kHeading1.copyWith(fontSize: FontSizes.s14),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SpaceHeight(6),
                          Html(data: item.details,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                               Text("${item.date}"),
                               // Html(data: item.date,),
                              // Text(Jiffy(item.date).startOf(Units.MINUTE).from(item.date)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
