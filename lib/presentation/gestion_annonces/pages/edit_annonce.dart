import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../export.dart';

class EditAnnonce extends StatefulWidget {
  const EditAnnonce({Key? key, required this.mesAnnonce}) : super(key: key);
  final MesAnnonceModel mesAnnonce;

  @override
  State<EditAnnonce> createState() => _EditAnnonceState();
}

class _EditAnnonceState extends State<EditAnnonce> {

  WalletUser? selectWalletUser;

  late TextEditingController quantityToGetController;
  late TextEditingController quantityToSellController;
  late TextEditingController reserveController;
  late TextEditingController minController;
  late TextEditingController maxController ;
  late TextEditingController qgetNameController ;
  late TextEditingController qgiveNameController ;
  late TextEditingController adressController ;
  late TextEditingController walletIdController ;

  @override
  void initState() {

    quantityToGetController = TextEditingController(text: widget.mesAnnonce.qget);
    quantityToSellController = TextEditingController(text: widget.mesAnnonce.qgive);
    minController = TextEditingController(text: widget.mesAnnonce.mMin);
    maxController = TextEditingController(text: widget.mesAnnonce.mMax);
    reserveController = TextEditingController(text: widget.mesAnnonce.reserve);
    qgetNameController = TextEditingController(text: widget.mesAnnonce.getCurrenciesName);
    qgiveNameController = TextEditingController(text: widget.mesAnnonce.giveCurrenciesName);
    adressController = TextEditingController(text: widget.mesAnnonce.adresseNum);
    walletIdController = TextEditingController(text: widget.mesAnnonce.adresseNum);

    selectWalletUser = context.read<ProfilCubit>().getUser!.wallet!.firstWhereOrNull((element) => element.currency!.id==int.parse(widget.mesAnnonce.getId!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: AppColors.white,
        body: BlocConsumer<AnnonceCubit, AnnonceState>(
          listener: (context, state){
            if(state.updateAnnonceStatus.isSubmissionFailure){
              String message="";
              state.message?.errors!.forEach((element) {
                message +="$element\n";
              });
              buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);
            }else if(state.updateAnnonceStatus.isSubmissionInProgress) {
            }else if(state.updateAnnonceStatus.isSubmissionSuccess){
              //buildWhitePopUpMessage(message: "${state.sucessMessage?.message}");
            }

          },
          builder: (context, stateAnnonce){
              if(stateAnnonce.sellCoinStatus.isSubmissionSuccess){
                return SingleChildScrollView(child: Column(children: [
                  SpaceHeight(50),
                  Center(child: Image.asset("assets/images/validate_icon.jpg", height: 200, width: 200,),),
                  SpaceHeight(100),
                  Text("${stateAnnonce.sucessMessage?.message}", textAlign: TextAlign.center, style: kSubtitle1,),
                  SpaceHeight(150),
                  ButtonWidget(
                      background: AppColors.primary,
                      textColor: AppColors.white,
                      text: "Home",
                      voidCallback: () {
                        context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.home);
                       // Get.offAll(DashboardScreen());
                      })
                ],),);
              }else{
                return SingleChildScrollView(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputTextField(
                          label: "Devise à vendre :",
                          hintText: '${widget.mesAnnonce.giveCurrenciesName}',
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          controller: qgiveNameController,
                          error:  null,
                          onChanged: (value){},
                        ),
                        const SpaceHeight(10),

                        InputTextField(
                          label: "Devise à recevoir :",
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller: qgetNameController,
                          error:  null,
                          onChanged: (value){},
                        ),
                      ],),

                    const SpaceHeight(10),
                    InputTextField(
                      label: "Donner : ${widget.mesAnnonce.giveCurrenciesName??""}",
                      hintText: '${widget.mesAnnonce.giveCurrenciesName??""}',
                      keyboardType: TextInputType.number,
                      controller: quantityToSellController,
                      error:  null,
                      onChanged: (value){},
                    ),
                    const SpaceHeight(10),

                    InputTextField(
                      label: "Recevoir : ${widget.mesAnnonce.getCurrenciesName??""}",
                      hintText: '${widget.mesAnnonce.getCurrenciesName??""}',
                      keyboardType: TextInputType.number,
                      controller: quantityToGetController,
                      error:  null,
                      onChanged: (value){},
                    ),

                    const SpaceHeight(10),

                    InputTextField(
                      label: "Mon adresse de réception ${widget.mesAnnonce.getCurrenciesName}",
                      hintText: "${selectWalletUser?.address}",
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      error:  null,
                      onChanged: (value){},
                    ),

                    /*Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mon adresse de réception : ${widget.mesAnnonce.getCurrenciesName}",
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
                                walletIdController.text = value!.id.toString();
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
                      label: "Réserve : ${widget.mesAnnonce.giveCurrenciesName}",
                      //hintText: 'xxxxx',
                      keyboardType: TextInputType.number,
                      controller: reserveController,
                      error:  null,
                      onChanged: (value){},
                    ),
                    const SpaceHeight(10),

                    InputTextField(
                      label: "Achat Min/Transaction",
                      hintText: 'Achat Min/Transaction',
                      keyboardType: TextInputType.number,
                      controller: minController,
                      error:  null,
                      onChanged: (value){},
                    ),
                    const SpaceHeight(10),
                    InputTextField(
                      label: "Achat Max/Transaction",
                      hintText: 'Achat Max/Transaction',
                      keyboardType: TextInputType.number,
                      controller: maxController,
                      error:  null,
                      onChanged: (value){},
                    ),
                    const SpaceHeight(20),
                    BlocConsumer<AnnonceCubit, AnnonceState>(
                      listener: (context, state){
                        if (state.updateAnnonceStatus.isSubmissionFailure) {
                          String message = "";
                          state.message?.errors?.forEach((element) {
                            message += "$element\n";
                          });
                          buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);
                        }else if(state.updateAnnonceStatus.isSubmissionSuccess){
                          Get.back();
                          buildWhitePopUpMessage(message: "${state.sucessMessage?.message}");

                        }
                      },
                        builder: (context, state){
                        return  state.updateAnnonceStatus.isSubmissionInProgress?Container(child: AppLoadingIndicator(),): ButtonWidget(
                            background: AppColors.primary,
                            textColor: AppColors.white,
                            text: "Mettre à jour",
                            voidCallback: () {
                              if(quantityToSellController.text.isNotEmpty
                                  && quantityToGetController.text.isNotEmpty
                                  && reserveController.text.isNotEmpty
                                  && minController.text.isNotEmpty
                                  && maxController.text.isNotEmpty
                              ){
                                context.read<AnnonceCubit>().updateAnnonce(
                                  announcementId: widget.mesAnnonce.trId,
                                  quantityToSell:quantityToSellController.text,
                                  quantityToGet:quantityToGetController.text,
                                  walletId:selectWalletUser?.currency?.id,
                                  reserve:reserveController.text,
                                  min:minController.text,
                                  max:maxController.text,
                                );
                              } else{
                                buildWhitePopUpMessage(message: "Tout les champs sont obligatoire");
                              }
                            }
                        );
                        },
                    ),
                  ],),
                ),);
              }

          },

        ));
  }
}
