import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/data/models/user_model.dart';

import '../../../export.dart';
import '../../widgets/image_container.dart';

class PostAnnonceScreen extends StatefulWidget {
  const PostAnnonceScreen({Key? key, required this.currencyExchange})
      : super(key: key);

  final CurrencyExchange currencyExchange;

  @override
  PostAnnonceScreenState createState() => PostAnnonceScreenState();
}

class PostAnnonceScreenState extends State<PostAnnonceScreen> {
  CurrencyExchange? selectCurrencyExchange;
  WalletUser? selectWalletUser;

  //TextEditingController reserveController =TextEditingController();
  late UserModel user;

  late TextEditingController quantityToGetController;
  late TextEditingController quantityToSellController;
  late TextEditingController reserveController;
  late TextEditingController minController;
  late TextEditingController maxController;

  bool isSelectCurrencyExchange = false;

  @override
  void initState() {
    super.initState();
    user = context.read<ProfilCubit>().getUser!;
    initController();
  }

  initController() {
    quantityToGetController = TextEditingController(text: "1");
    quantityToSellController = TextEditingController(text: "1");
    reserveController = TextEditingController();
    minController = TextEditingController(text: "1");
    maxController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: AppColors.white,
        body: BlocConsumer<AnnonceCubit, AnnonceState>(
          listener: (context, state) {
            if (state.sellCoinStatus.isSubmissionFailure) {
              String message = "";
              state.message?.errors!.forEach((element) {
                message += element;
              });
              buildWhitePopUpMessage(
                  message: message.isEmpty ? state.message!.release! : message);
            } else if (state.sellCoinStatus.isSubmissionInProgress) {
            } else if (state.sellCoinStatus.isSubmissionSuccess) {
              //buildWhitePopUpMessage(message: "${state.sucessMessage?.message}");
            }
            // Get.offAll(DashboardScreen());
          },
          builder: (context, stateAnnonce) {
            if (stateAnnonce.deviseListStatus.isSubmissionSuccess) {
              if (stateAnnonce.sellCoinStatus.isSubmissionSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SpaceHeight(50),
                      Center(
                        child: Image.asset(
                          "assets/images/validate_icon.jpg",
                          height: 200,
                          width: 200,
                        ),
                      ),
                      SpaceHeight(100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "${stateAnnonce.sucessMessage?.message}",
                          textAlign: TextAlign.center,
                          style: kSubtitle1,
                        ),
                      ),
                      SpaceHeight(150),
                      ButtonWidget(
                          background: AppColors.primary,
                          textColor: AppColors.white,
                          text: "Home",
                          voidCallback: () {
                            context.read<AnnonceCubit>().resetStatut();
                            initController();
                            context
                                .read<AppMenuCubit>()
                                .setNavBarItem(AppMenuItem.home);
                            Get.offAll(DashboardScreen());
                          })
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sélectionnez la devise à recevoir",
                              style: kSubtitle1,
                            ),
                            const SpaceHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: AppColors.grey)),
                              child: DropdownButtonFormField<CurrencyExchange>(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                ),
                                hint: Text('Aucun'),
                                isExpanded: true,
                                isDense: true,
                                value: selectCurrencyExchange,
                                selectedItemBuilder: (BuildContext context) {
                                  return stateAnnonce.deviseList!
                                      .map<Widget>((CurrencyExchange? item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: Row(
                                          children: [
                                            ImageContainer(
                                              margin: EdgeInsets.only(left: 20),
                                              url: "${item?.currencyImage}",
                                            ),
                                            SpaceWidth(10),
                                            Text("${item?.currencyName}"),
                                          ],
                                        ));
                                  }).toList();
                                },
                                items: stateAnnonce.deviseList!
                                    .map((CurrencyExchange item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Row(
                                      children: [
                                        ImageContainer(
                                          margin: EdgeInsets.only(left: 20),
                                          url: "${item.currencyImage}",
                                        ),
                                        SpaceWidth(10),
                                        Text("${item.currencyName}"),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {

                                  selectCurrencyExchange = value;

                                  selectWalletUser = context
                                      .read<ProfilCubit>()
                                      .getUser!
                                      .wallet!
                                      .firstWhereOrNull((element) =>
                                          element.currency!.id ==
                                          selectCurrencyExchange?.currenciesId);

                                  setState(() {
                                    isSelectCurrencyExchange = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(10),
                        InputTextField(
                          label:
                              "Donner : ${widget.currencyExchange.currencyName}",
                          hintText: '${widget.currencyExchange.currencyName}',
                          keyboardType: TextInputType.number,
                          controller: quantityToSellController,
                          error: null,
                          onChanged: (value) {
                            minController.text = value;
                          },
                        ),
                        const SpaceHeight(10),
                        InputTextField(
                          label:
                              "Recevoir : ${selectCurrencyExchange?.currencyName ?? ""}",
                          hintText:
                              '${selectCurrencyExchange?.currencyName ?? ""}',
                          keyboardType: TextInputType.number,
                          controller: quantityToGetController,
                          error: null,
                          onChanged: (value) {},
                        ),
                        const SpaceHeight(10),
                        InputTextField(
                          label:
                              "Réserve : ${widget.currencyExchange.currencyName}",
                          //hintText: 'xxxxx',
                          keyboardType: TextInputType.number,
                          controller: reserveController,
                          error: null,
                          onChanged: (value) {
                            maxController.text = value;
                          },
                        ),
                        const SpaceHeight(10),
                        InputTextField(
                          label:
                              "Adresse de reception ${selectWalletUser?.address==null? "":selectWalletUser?.currency?.acronym}",
                          hintText: selectWalletUser?.address==null? "":"${selectWalletUser?.address}",
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          error: null,
                          onChanged: (value) {},
                        ),
                        Visibility(
                            visible:
                                user.wallet == null || user.wallet!.isEmpty || (isSelectCurrencyExchange && selectWalletUser==null),
                            child: Column(children: [
                              Text.rich( TextSpan(children: [
                                TextSpan(text: "Si inexistant, veillez l'ajouter d'abord dans", children: [
                                  TextSpan(text: " Mes portefeuilles",
                                      style: kSubtitle2.copyWith(color: AppColors.error),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                          context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.profil);
                                        }),
                                ]),
                              ]),
                                style: kSubtitle2,
                              ),
                            ])),

                        /*Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adresse portefeuille ou Numéro",
                          style: kSubtitle1,
                        ),
                        const SpaceHeight(10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: AppColors.grey)),
                          child: DropdownButtonFormField<WalletUser>(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              //fillColor: Colors.grey[300],
                            ),
                            hint: Text('Aucun'),
                            isExpanded: true,
                            isDense: true,
                            value: selectWalletUser,
                            selectedItemBuilder: (BuildContext context) {
                              return user.wallet!.map<Widget>((WalletUser? item) {
                                return DropdownMenuItem(value: item, child: Text("${item?.currency?.name}"));
                              }).toList();
                            },
                            items: user.wallet!.map((WalletUser? item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text("${item?.currency?.name}"),
                              );
                            }).toList(),
                            onChanged:(value){
                              selectWalletUser = value;
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Visibility(visible: user.wallet==null || user.wallet!.isEmpty, child: Column(children: [
                          Text(
                            "Ajouter une adresse a votre compte pour continuer l'operation",
                            style: kSubtitle1.copyWith(fontSize: 12, color: AppColors.error),
                          ),
                        ],))
                      ],),*/
                        const SpaceHeight(10),
                        InputTextField(
                          label: "Achat ${widget.currencyExchange.currencyAcronym} Min/Transaction ",
                          hintText: 'Achat Min/Transaction',
                          keyboardType: TextInputType.number,
                          controller: minController,
                          error: null,
                          onChanged: (value) {},
                        ),
                        const SpaceHeight(10),
                        InputTextField(
                          label: "Achat ${widget.currencyExchange.currencyAcronym} Max/Transaction",
                          hintText: 'Achat Max/Transaction',
                          keyboardType: TextInputType.number,
                          controller: maxController,
                          error: null,
                          onChanged: (value) {},
                        ),
                        const SpaceHeight(20),
                        BlocBuilder<AnnonceCubit, AnnonceState>(
                            builder: (context, state) {
                          return state.sellCoinStatus.isSubmissionInProgress
                              ? Container(
                                  child: AppLoadingIndicator(),
                                )
                              : ButtonWidget(
                                  width: 200,
                                  height: 40,
                                  background: AppColors.primary,
                                  textColor: AppColors.white,
                                  text: "Placer une offre",
                                  voidCallback: () {
                                    if (widget.currencyExchange.currenciesId ==
                                        selectCurrencyExchange?.currenciesId) {
                                      buildWhitePopUpMessage(
                                          message:
                                              "Vous ne pouvez pas echanger le meme crypto");
                                    } else if (quantityToSellController
                                            .text.isNotEmpty &&
                                        selectCurrencyExchange != null &&
                                        quantityToGetController
                                            .text.isNotEmpty &&
                                        selectWalletUser != null &&
                                        reserveController.text.isNotEmpty &&
                                        minController.text.isNotEmpty &&
                                        maxController.text.isNotEmpty) {
                                      context.read<AnnonceCubit>().sellCoin(
                                            currencyToSell: widget
                                                .currencyExchange.currenciesId,
                                            quantityToSell:
                                                quantityToSellController.text,
                                            currencyToGet:
                                                selectCurrencyExchange
                                                    ?.currenciesId,
                                            quantityToGet:
                                                quantityToGetController.text,
                                            walletId:
                                                selectWalletUser?.currency?.id,
                                            reserve: reserveController.text,
                                            min: minController.text,
                                            max: maxController.text,
                                          );
                                    } else {
                                      buildWhitePopUpMessage(
                                          message:
                                              "Tout les champs sont obligatoire");
                                    }
                                  });
                        }),
                      ],
                    ),
                  ),
                );
              }
            } else if (stateAnnonce.deviseListStatus.isSubmissionInProgress) {
              return Text("Progress");
            } else {
              return Text("error");
            }
          },
        ));
  }
}
