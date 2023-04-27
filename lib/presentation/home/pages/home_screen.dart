import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart' as timer;

import '../../../export.dart';
import '../../widgets/countdown_timer.dart';
import '../../widgets/image_container.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TrxResponse? trxResponse;

  @override
  void initState() {
    initializeDateFormatting();
    context.read<ProfilCubit>().fetchUser();
    trxResponse = context.read<HomeCubit>().trxResponse;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
      if (state.status == FormzStatus.submissionSuccess) {
       // loadingOverlay.hide();
      //  Get.offAllNamed(RoutePaths.dashboardScreen);
      } else if (state.status == FormzStatus.submissionInProgress) {
       // return loadingOverlay.show(context);
      }else if(state.status == FormzStatus.submissionFailure){
       // loadingOverlay.hide();
        String message = "";
        state.message?.errors?.forEach((element) {
          message += "$element\n";
        });
        buildWhitePopUpMessage(message: message);
      }
    },
          child: RefreshIndicator(
              onRefresh: () => refresh(),
              strokeWidth: 2,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state.brandStatus.isSubmissionSuccess) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  setState(() {
                                  });
                                });
                                return ImageSliderWidget(
                                  imageUrls: state.brandImage!.data!,
                                );
                              } else if (state.trxStatus.isSubmissionFailure) {
                                return CustomError(
                                    errorMessage: state.errorMessage!);
                              } else {
                                return Center(child: AppLoadingIndicator());
                              }
                            }),
                        const SpaceHeight(6),
                        BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state.trxStatus.isSubmissionSuccess) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  trxResponse = state.trxResponse;
                                });
                                return AccountDetail(
                                  model: state.trxResponse,
                                  animationController: widget.animationController,
                                );
                              } else if (state.trxStatus.isSubmissionFailure) {
                                return CustomError(
                                    errorMessage: state.errorMessage!);
                              } else {
                                return Center(child: AppLoadingIndicator());
                              }
                            }),
                        SpaceHeight(10),
                        BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state.trxStatus.isSubmissionSuccess) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  setState(() {
                                    trxResponse = state.trxResponse;
                                  });
                                });
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Text(
                                            "Transactions récentes",
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => context
                                                .read<AppMenuCubit>()
                                                .setNavBarItem(
                                                AppMenuItem.purchases),
                                            child: const Text(
                                              "Voir tout",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xc42972ff),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 170.h,
                                      //height: 175.0,
                                      child: trxResponse
                                          ?.data?.trx?.data?.length ==
                                          0
                                          ? Center(
                                        child: Text(
                                            "Aucune transaction enregistré sur votre compte"),
                                      )
                                          : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: trxResponse
                                            ?.data?.trx?.data?.length ??
                                            0,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(8),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(
                                                          10.0),
                                                      topRight:
                                                      Radius.circular(
                                                          10.0),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return MinimalDetailPurchases(
                                                      trx: trxResponse
                                                          ?.data
                                                          ?.trx
                                                          ?.data?[index],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 320.w,
                                                margin:
                                                const EdgeInsets.all(8),
                                                padding:
                                                const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          ImageContainer(
                                                            url:
                                                            "${trxResponse?.data?.trx?.data?[index].currencyGetImage}",
                                                          ),
                                                          Text(
                                                              "${trxResponse?.data?.trx?.data?[index].currencyGetAcronym}"),
                                                          SpaceWidth(5),
                                                          (trxResponse!.data!.trx!.data![index].status ==
                                                              "0" &&
                                                              trxResponse!.data!.trx!.data![index].resteTimeout! >
                                                                  0)
                                                              ?

                                                          CountdownTimer(
                                                              trxId:trxResponse!
                                                                  .data!.trx!.data![index].id.toString(),
                                                              trxcancel: trxResponse!
                                                                  .data!
                                                                  .trx!
                                                                  .data![
                                                              index]
                                                                  .trxcancel!,
                                                              resteTimeout: trxResponse!
                                                                  .data!
                                                                  .trx!
                                                                  .data![
                                                              index]
                                                                  .resteTimeout!)
                                                              : Container(),
                                                          SpaceWidth(5),
                                                          statusUi(
                                                              "${trxResponse?.data?.trx?.data?[index].status!}")
                                                        ],
                                                      ),
                                                      SpaceHeight(10),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    "Achat"),
                                                                SpaceHeight(
                                                                    10),
                                                                Text(
                                                                    "Pour donner"),
                                                                SpaceHeight(
                                                                    10),
                                                                Text(
                                                                    "Paiement"),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                      "${double.parse(trxResponse!.data!.trx!.data![index].qGet!).toStringAsFixed(2)} ${trxResponse?.data?.trx?.data?[index].currencyGetBasic} ${trxResponse?.data?.trx?.data?[index].currencyGetAcronym}"),
                                                                  SpaceHeight(
                                                                      10),
                                                                  Text(
                                                                      "${double.parse(trxResponse!.data!.trx!.data![index].qGive!).toStringAsFixed(2)} ${trxResponse?.data?.trx?.data?[index].currencyGiveBasic} ${trxResponse?.data?.trx?.data?[index].currencyGiveAcronym}"),
                                                                  SpaceHeight(
                                                                      10),
                                                                  Text(
                                                                      "${trxResponse?.data?.trx?.data?[index].currencyGiveApi == 0 ? "${trxResponse?.data?.trx?.data?[index].currencyGiveAcronym}" : "Via API"}"),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state.trxStatus.isSubmissionFailure) {
                                return CustomError(
                                    errorMessage: state.errorMessage!);
                              } else {
                                return Center(child: AppLoadingIndicator());
                              }
                            }),
                        SpaceHeight(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                "Annonces",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                              ),
                              InkWell(
                                onTap: () => context
                                    .read<AppMenuCubit>()
                                    .setNavBarItem(AppMenuItem.annonce),
                                child: const Text(
                                  "Voir tout",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xc42972ff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SpaceHeight(10),
                        BlocBuilder<AnnonceCubit, AnnonceState>(
                            builder: (context, state) {
                              if (state.annonceListStatus.isSubmissionSuccess) {
                                return state.annoncesList!.length == 0
                                    ? Container(
                                  child: Text("Aucune annonces en ligne."),
                                )
                                    : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    var annonce = state.annoncesList![index];
                                    return AnnonceIterm(
                                      annonce: annonce,
                                    );
                                  },
                                  itemCount: state.annoncesList?.length == null
                                      ? 0
                                      : state.annoncesList!.length > 10
                                      ? 10
                                      : state.annoncesList!.length,
                                );
                              } else if (state
                                  .annonceListStatus.isSubmissionFailure) {
                                return CustomError(errorMessage: state.message!);
                              } else {
                                return Center(child: AppLoadingIndicator());
                              }
                            }),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => context
                                .read<AppMenuCubit>()
                                .setNavBarItem(AppMenuItem.annonce),
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 15,
                                bottom: 100,
                              ),
                              child: Text(
                                "Voir tout",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xc42972ff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
    ));
  }

  Future<void> refresh() async {
    context.read<AnnonceCubit>().fetchAnnonceList();
    context.read<HomeCubit>().fetchTransaction();
    context.read<ProfilCubit>().fetchUser();
    context.read<HomeCubit>().fetchBrandImage();
    context.read<AnnonceCubit>().fetchExchangeListe();
  }
}
