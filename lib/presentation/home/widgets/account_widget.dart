import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/infrastructure/utils/other.dart';
import 'package:marketscc/presentation/widgets/image_container.dart';

import '../../../export.dart';

class AccountDetail extends StatelessWidget {
  final AnimationController animationController;
  final TrxResponse? model;

  AccountDetail({Key? key, this.model, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Wallet> wallet = model?.data?.wallet ?? [];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 155,
                margin: const EdgeInsets.only(right: 8, left: 8),
                padding: const EdgeInsets.only(left: 8, right: 30),
                decoration: BoxDecoration(
                  color: AppColors.primary2,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(0.1, 0.1),
                      blurRadius: 0.2,
                      spreadRadius: 0.2,
                    ),
                    const BoxShadow(
                        color: AppColors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 30,
                              color: AppColors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MES BONUS",
                                style: kSubtitle2.copyWith(
                                    color: AppColors.yellow,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                "${model?.data?.bonus} ${model?.data?.basic}",
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.clip,
                                style:
                                    kSubtitle2.copyWith(color: AppColors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SpaceHeight(20),
                    BlocBuilder<ProfilCubit, ProfilState>(
                        builder: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "VERIFICATION KYC",
                              style:
                                  kSubtitle2.copyWith(color: AppColors.yellow),
                            ),
                            const SpaceHeight(10),
                            //Text("${state.userData.user?.status}")
                            Text(
                                "${statusCompte(state.userResponse?.user?.verified).lead}",
                                style: kSubtitle2.copyWith(
                                    fontSize: FontSizes.s10,
                                    color: AppColors.white)),
                            Text(
                                "${statusCompte(state.userResponse?.user?.verified).sub}",
                                style: kSubtitle2.copyWith(
                                    fontSize: FontSizes.s10,
                                    color: AppColors.white)),
                          ],
                        );
                      } else if (state.status.isSubmissionFailure) {
                        return Center(
                            child: Text("${state.message?.debug}",
                                textAlign: TextAlign.center,
                                style: kSubtitle2.copyWith(
                                    fontSize: FontSizes.s10,
                                    color: AppColors.error)));
                      } else {
                        return Center(
                            child: AppLoadingIndicator(
                          color: AppColors.white,
                        ));
                      }
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 75,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [
                            AppColors.primary1.withOpacity(0.9),
                            AppColors.primary1.withOpacity(1),
                          ],
                          transform: const GradientRotation(math.pi / 4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(0.1, 0.1),
                            blurRadius: 0.2,
                            spreadRadius: 0.2,
                          ),
                          const BoxShadow(
                              color: AppColors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 15),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 30,
                                    color: AppColors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text("TOTAL ACHATS APPROUVÉS",
                                      style: kSubtitle2.copyWith(
                                          color: AppColors.yellow)),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${model?.data?.buy}",
                                style:
                                    kSubtitle2.copyWith(color: AppColors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SpaceHeight(5),
                    Container(
                      height: 75,
                      margin: const EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [
                            AppColors.primary3.withOpacity(0.9),
                            AppColors.primary3.withOpacity(1),
                          ],
                          transform: const GradientRotation(math.pi / 4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(0.1, 0.1),
                            blurRadius: 0.2,
                            spreadRadius: 0.2,
                          ),
                          const BoxShadow(
                              color: AppColors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 30,
                                    color: AppColors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "TOTAL VENTES APPROUVÉES",
                                    style: kSubtitle2.copyWith(
                                        color: AppColors.yellow),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${model?.data?.sell}",
                                style:
                                    kSubtitle2.copyWith(color: AppColors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
        const SpaceHeight(10),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Tableau de bord",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: wallet.length == 0
                        ? null
                        : () {
                      Get.toNamed(RoutePaths.wallet, arguments: wallet,);
                      /*  animationController.reset();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    content: SizedBox(
                                      height: Get.height / 2,
                                      width: Get.width,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const SpaceHeight(5),
                                        scrollDirection: Axis.vertical,
                                        itemCount: wallet.length,
                                        shrinkWrap: true,
                                        // padding: const EdgeInsets.all(8),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 0,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 10,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: ImageContainer(url:"${wallet[index].currencyImage}"),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            "${wallet[index].deviseSymbol}"),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .arrow_downward),
                                                            Text(
                                                                "${wallet[index].totalPurchase}"),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .arrow_upward),
                                                            Text(
                                                                "${wallet[index].totalSale}"),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                });*/
                          },
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
            wallet.length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Aucun wallet disponible sur votre compte.",
                        style: kHeading4,
                      ),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SpaceHeight(5);
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: wallet.length > 3 ? 3 : wallet.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: ImageContainer(url:"${wallet[index].currencyImage}"),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("${wallet[index].deviseSymbol}"),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_downward),
                                        Text(
                                            "${wallet[index].totalPurchase}${wallet[index].basic}"),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_upward),
                                        Text(
                                            "${wallet[index].totalSale}${wallet[index].basic}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        )
      ],
    );
  }
}
