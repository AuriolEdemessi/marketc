import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../export.dart';

class AnnonceIterm extends StatelessWidget {
   AnnonceIterm({
    Key? key,
    required this.annonce,
  }) : super(key: key);

   final AnnonceModel annonce;


   @override
  Widget build(BuildContext context) {

    return InkWell(
        borderRadius: BorderRadius.circular(16.0),
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if(context.read<ProfilCubit>().getUser!.userId==annonce.userId){
            buildWhitePopUpMessage(message: 'Vous ne pouvez pas faire un achat sur votre propore annonce de vente');
          }else{
            Get.toNamed(RoutePaths.exchange, arguments: annonce);
          }
        },
        child: Container(
          //height: 143,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${annonce.username}",
                          style: kHeading1.copyWith(
                              fontSize: FontSizes.s14,
                              color:
                              AppColors.nearlyDarkBlue),
                        ),
                        const Spacer(),
                        Text(
                          "1/1000",
                          style: kHeading1.copyWith(
                              fontSize: FontSizes.s14),
                        ),
                      ],
                    ),

                    const SpaceHeight(6),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Text(
                              "Reserve",
                              style: kHeading1.copyWith(
                                  fontSize: FontSizes.s14),
                            ),
                            Text(
                              "${double.parse(annonce.reserve!).toStringAsFixed(2)} "+"${annonce.giveSymbol}",
                              style: kSubtitle2,
                            ),
                          ],
                        ),),
                        Expanded(child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Text(
                              "Vendre",
                              style: kHeading1.copyWith(
                                  fontSize: FontSizes.s14),
                            ),
                            Text(
                              "${annonce.qgive} ${annonce.giveSymbol}",
                              style: kSubtitle2,
                            ),
                          ],
                        ),),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Recevoir",
                              style: kHeading1.copyWith(
                                  fontSize: FontSizes.s14),
                            ),
                            Text("${annonce.qget} ${annonce.getSymbol}	",
                                style: kSubtitle2),
                          ],
                        ),)
                        // Text("Revendeur"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}