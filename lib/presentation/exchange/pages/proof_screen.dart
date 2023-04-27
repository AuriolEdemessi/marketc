import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../../../export.dart';

class ProofScreen extends StatefulWidget {
  const ProofScreen({Key? key, required this.buyInfo}) : super(key: key);
  final BuyInfo buyInfo;

  @override
  State<ProofScreen> createState() => _ProofScreenState();
}

class _ProofScreenState extends State<ProofScreen> {
  File? imageFilePhoto;
  bool isValidePhoto = false;
  String? fileNamePhoto;

  late TextEditingController motifController;

  @override
  void initState() {
    motifController = TextEditingController(
        text: "${context.read<ProfilCubit>().getUser!.username} "
            "${widget.buyInfo.trxId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      showBack: widget.buyInfo.back
      ),
      backgroundColor: AppColors.white,
      body: BlocConsumer<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          if (state.sendProofStatus == FormzStatus.submissionFailure) {
            String message = "";
            state.message?.errors?.forEach((element) {
              message += "$element\n";
            });
            buildWhitePopUpMessage(
                message: message.isEmpty ? state.message!.release! : message);
          }
        },
        builder: (context, state) {
          if (state.sendProofStatus.isSubmissionSuccess) {

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    Text(
                      "${state.sucessMessage?.message}",
                      textAlign: TextAlign.center,
                      style: kSubtitle1,
                    ),
                    SpaceHeight(150),
                    ButtonWidget(
                        background: AppColors.primary,
                        textColor: AppColors.white,
                        text: "Retour à l'accueil",
                        voidCallback: () {
                          context.read<ExchangeCubit>().resetStatut();
                          context
                              .read<AppMenuCubit>()
                              .setNavBarItem(AppMenuItem.home);
                          dio.Get.offAll(DashboardScreen());
                        }),
                    SpaceHeight(kToolbarHeight)
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Confirmer le paiement",
                        style: kSubtitle2.copyWith(fontSize: 18)),
                    SpaceHeight(20),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Votre n° de commande ",
                          style: kSubtitle2.copyWith(fontSize: 18)),
                      TextSpan(
                          text: "${widget.buyInfo.trxId}",
                          style: kSubtitle2.copyWith(
                              color: AppColors.error, fontSize: 18)),
                      TextSpan(
                          text: " a été créé avec succès.",
                          style: kSubtitle2.copyWith(fontSize: 18)),
                    ])),
                    SpaceHeight(20),
                    Text(
                        "Le solde des jetons n’apparaîtra dans votre compte qu’une fois que votre transaction aura été confirmée et approuvée par notre équipe.",
                        style: kSubtitle2.copyWith(fontSize: 18)),
                    SpaceHeight(20),
                    Text(
                        "Pour accélérer la vérification ou le traitement entrer uniquement l'adresse ou le numéro de téléphone valide s’il vous plaît (d’où vous transférerez à notre adresse.)",
                        style: kSubtitle2.copyWith(fontSize: 18)),

                    SpaceHeight(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Informations pour le paiement Adresse de paiement :",
                            style: kSubtitle2.copyWith(fontSize: 18)),
                        SpaceHeight(10),
                        Text(
                            "PAIEMENT VIA ${widget.buyInfo.currencyName}",
                            style: kSubtitle2.copyWith(fontSize: 18)),
                        Column(
                          children: [
                            SpaceHeight(10),
                            Row(
                              children: [
                                Text(
                                    "${widget.buyInfo.address}",
                                    style: kSubtitle2.copyWith(fontSize: 18)),
                                IconButton(
                                    onPressed: () {
                                      FlutterClipboard.copy("${widget.buyInfo.address}")
                                          .then((value) {
                                        buildWhitePopUpMessage(message: "copie");
                                      });
                                    },
                                    icon: Icon(Icons.copy))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SpaceHeight(20),
                    InputTextField(
                      label: "Motif de paiement",
                      hintText: '',
                      isSuffixIcon: true,
                      suffixWidget: IconButton(
                        icon: const Icon(Icons.paste),
                        onPressed: () {
                          FlutterClipboard.paste().then((value) {
                            motifController.text = value;
                          });
                        },
                      ),
                      controller: motifController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                    SpaceHeight(10),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: AppColors.grey)),
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (builder) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  padding: const EdgeInsets.only(
                                    bottom: 15.0,
                                    left: 15.0,
                                    right: 15.0,
                                    top: 10.0,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Selection une source"),
                                      const SpaceHeight(50),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                              onTap: () => pickImageFromGallery(
                                                  imageSource:
                                                      ImageSource.gallery),
                                              child: Column(
                                                children: [
                                                  Icon(Icons
                                                      .photo_library_outlined),
                                                  Text("Galerie")
                                                ],
                                              )),
                                          GestureDetector(
                                              onTap: () => pickImageFromGallery(
                                                  imageSource:
                                                      ImageSource.camera),
                                              child: Column(
                                                children: [
                                                  Icon(Icons.camera),
                                                  Text("Caméra")
                                                ],
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(imageFilePhoto != null
                                  ? "${fileNamePhoto}"
                                  : "Téléversement de fichiers"),
                            ),
                            Icon(Icons.upload)
                          ],
                        ),
                      ),
                    ),
                    SpaceHeight(20),
                    Center(
                      child: state.sendProofStatus.isSubmissionInProgress
                          ? Container(
                              child: AppLoadingIndicator(),
                            )
                          : InkWell(
                              onTap: () async {
                                if (isValidePhoto &&
                                    motifController.text.isNotEmpty) {
                                  FormData formData = FormData.fromMap({
                                    "image": await MultipartFile.fromFile(
                                        imageFilePhoto!.path),
                                    "trx_id": widget.buyInfo.trxId,
                                    "motif": motifController.text,
                                  });
                                  context
                                      .read<ExchangeCubit>()
                                      .sendProof(data: formData);
                                } else {
                                  buildWhitePopUpMessage(
                                      message:
                                          "Tout les champs sont obligatoire");
                                }
                              },
                              child: ButtonWidget(
                                background:AppColors.primary,
                                textColor: AppColors.white,
                                text: "Confirmer le paiement",
                              )

                              /*Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.primary1,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColors.primary1)),
                                child: Text(
                                  "Confirmer le paiement",
                                  textAlign: TextAlign.center,
                                  style: kSubtitle2.copyWith(
                                      color: AppColors.white),
                                ),
                              ),*/
                            ),
                    )
                  ],
                ),
              ),
            );
          }
        },

      ),
    );
  }

  Future<void> pickImageFromGallery({required ImageSource imageSource}) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);

    imageFilePhoto = (pickedImage != null ? File(pickedImage.path) : null)!;
    if (imageFilePhoto != null) {
      setState(() {
        isValidePhoto = true;
        fileNamePhoto = imageFilePhoto!.path.split('/').last;
        Navigator.of(context).pop();
      });
    }
  }
}
