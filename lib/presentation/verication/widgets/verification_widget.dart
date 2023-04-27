import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dio/dio.dart' as dio;

import '../../../export.dart';

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  File? firstImageFilePhoto;
  File? secondImageFilePhoto;
  bool isValidePhoto = false;

  String? firstFileNamePhoto;
  String? secondFileNamePhoto;

  bool addNew = true;
  bool firstPickupImage = false;
  bool secondPickupImage = false;

  bool firstSelect = false;
  bool secondSelect = false;

  String? _selectedPicTypeDoc;

  static const _picTypeDoc = [
    'Permis de conduire',
    'Passeport international',
    'Carte d\'identité nationale',
    'Carte d\'électeur',
  ];

  bool isChecked = false;

  String selectedExpireDate = "";
  bool dateEmpty = false;

  TextEditingController textEditingControllerNumber = TextEditingController();
  TextEditingController textEditingControllereExpireDate =
      TextEditingController();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceHeight(10),
        Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Text(
                    "Vérification du compte",
                    textAlign: TextAlign.center,
                    style: kHeading3,
                  ),
                  SpaceHeight(5),
                  Text(
                    "La vérification d’identité vous rend éligible aux échanges de pièces, aux promotions et aux offres",
                    style: kSubtitle2,
                  )
                ],
              ),
            )),
        SpaceHeight(20),
        Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          decoration: BoxDecoration(color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.grey),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text("01"),
                    ),
                  ),
                  SpaceWidth(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Document téléversé",
                        style: kHeading4,
                      ),
                      SpaceHeight(5),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Pour vérifier votre identité, veuillez télécharger n’importe lequel de vos documents",
                          style: kSubtitle2,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                  ),
                  SpaceWidth(15),
                  SizedBox(
                    width: 300,
                    child: Text(
                        "Pour compléter, veuillez télécharger l’un des documents personnels suivants."),
                  )
                ],
              ),
              SpaceHeight(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //ma: WrapAlignment.start,
                    children: [
                      Text(
                        "Passeport,",
                        style: kSubtitle2.copyWith(color: AppColors.error),
                      ),
                      Text(
                        "Permis de conduire,",
                        style: kSubtitle2.copyWith(color: AppColors.error),
                      ),
                      Text(
                        "Carte d'identité nationale",
                        style: kSubtitle2.copyWith(color: AppColors.error),
                      )
                    ],
                  ),
                ],
              ),
              SpaceHeight(10),
              Text(
                "Pour éviter les retards lors de la vérification du compte, veuillez vous assurer que :",
                style: kSubtitle2.copyWith(fontWeight: FontWeight.w800),
              ),
              SpaceHeight(5),
              Text(
                "- les informations d’identification ne sont pas expirer;",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Text(
                "- le document doit être en bon état et clairement lisible;",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Text(
                "- il n’y a pas des parties illisibles sur la carte;",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Text(
                "- on a une vue d’ensemble du document",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      firstSelect = true;
                      secondSelect = false;
                    });
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 4,
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
                                            imageSource: ImageSource.gallery),
                                        child: Column(
                                          children: [
                                            Icon(
                                                Icons.photo_library_outlined),
                                            Text("Galerie")
                                          ],
                                        )),
                                    GestureDetector(
                                        onTap: () => pickImageFromGallery(
                                            imageSource: ImageSource.camera),
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
                        child: Text(firstPickupImage
                            ? "${firstFileNamePhoto}"
                            : "Téléversement de fichiers"),
                      ),
                      Icon(Icons.upload)
                    ],
                  ),
                ),
              ),
              SpaceHeight(10),
              Text(
                "Téléchargez ici une photo de vous tenant le document",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      firstSelect = false;
                      secondSelect = true;
                    });
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 4,
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
                                            imageSource: ImageSource.gallery),
                                        child: Column(
                                          children: [
                                            Icon(
                                                Icons.photo_library_outlined),
                                            Text("Galerie")
                                          ],
                                        )),
                                    GestureDetector(
                                        onTap: () => pickImageFromGallery(
                                            imageSource: ImageSource.camera),
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
                        child: Text(secondPickupImage
                            ? "${secondImageFilePhoto}"
                            : "Téléversement de fichiers"),
                      ),
                      //Spacer(),
                      Icon(Icons.upload)
                    ],
                  ),
                ),
              ),
              SpaceHeight(10),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.grey),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text("02"),
                    ),
                  ),
                  SpaceWidth(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Détails de l’ID",
                        style: kHeading4,
                      ),
                      SpaceHeight(5),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Sélectionnez le type d’ID, entrez le numéro d’IDENTIFICATION et la date d’expiration inscrit sur votre document d’identification",
                          style: kSubtitle2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Text(
                "Document Type ",
                style: kSubtitle2,
              ),
              SpaceHeight(5),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)),
                child: DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    //fillColor: Colors.grey[300],
                  ),
                  hint: Text('Choisir...'),
                  isExpanded: true,
                  isDense: true,
                  value: _selectedPicTypeDoc,
                  selectedItemBuilder: (BuildContext context) {
                    return _picTypeDoc.map<Widget>((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList();
                  },
                  items: _picTypeDoc.map((item) {
                    if (item == _selectedPicTypeDoc) {
                      return DropdownMenuItem(
                        value: item,
                        child: Container(
                            height: 48.0,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: double.infinity,
                            color: Colors.grey,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item,
                              ),
                            )),
                      );
                    } else {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }
                  }).toList(),
                  //  validator: (String? value) => value?.isEmpty ?? true ? 'Cannot Empty' : null,
                  onChanged: (selectedItem) => setState(
                        () {
                      _selectedPicTypeDoc = selectedItem as String;
                    },
                  ),
                ),
              ),
              SpaceHeight(10),
              Column(
                children: [
                  InputTextField(
                    label: "Numéro d’identification",
                    hintText: '',
                    keyboardType: TextInputType.text,
                    controller: textEditingControllerNumber,

                    //error: state.email.invalid ? 'Invalid adresse email' : null,
                    onChanged: (value) {},
                  ),
                  SpaceHeight(5),
                  Text(
                    "(Remarque : Assurez-vous d’entrer un numéro d’identification complet.",
                    style: kSubtitle2.copyWith(fontSize: 9),
                  ),
                ],
              ),
              SpaceHeight(10),
              InputTextField(
                label: "Date d’expiration de l’ID :",
                hintText: '',
                keyboardType: TextInputType.text,
                controller: textEditingControllereExpireDate,
                readOnly: true,
                isSuffixIcon: true,
                suffixWidget: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                            backgroundColor: Colors.white,
                            content: SizedBox(
                              height: 300,
                              width: 300,
                              child: SfDateRangePicker(
                                selectionColor: AppColors.primary,
                                enablePastDates: false,
                                //maxDate: DateTime.now(),
                                todayHighlightColor: AppColors.primary,
                                onSelectionChanged: _onSelectionDate,
                                selectionMode:
                                DateRangePickerSelectionMode.single,
                                showActionButtons: true,
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onSubmit: (value) {
                                  Navigator.of(context).pop();
                                },
                                confirmText: "Select",
                                cancelText: "Annuler",
                              ),
                            ));
                      },
                    );
                  },
                  child: Icon(Icons.calendar_month),
                ),
                onChanged: (value) {},
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        //color: AppColors.primary,
                        borderRadius:
                        BorderRadius.all(Radius.circular(RadiusSizes.r5)),
                      ),
                      child: isChecked
                          ? const Icon(
                        Icons.check_box,
                        size: 24.0,
                        color: AppColors.primary,
                      )
                          : const Icon(
                        Icons.check_box_outline_blank,
                        size: 24.0,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  //SpaceWidth(8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: kSubtitle1,
                        children: [
                          TextSpan(
                              text:
                              'Je suis d\'accord avec la Politique de confidentialité, ',
                              style: kSubtitle2.copyWith()),
                          TextSpan(
                            text: 'les termes  & conditions ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Get.offAllNamed(RoutePaths.loginScreen),
                            style: kSubtitle2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(
                            text: 'de Marketscc',
                            style: kSubtitle2.copyWith(),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              SpaceHeight(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        //color: AppColors.primary,
                        borderRadius:
                        BorderRadius.all(Radius.circular(RadiusSizes.r5)),
                      ),
                      child: isChecked
                          ? const Icon(
                        Icons.check_box,
                        size: 24.0,
                        color: AppColors.primary,
                      )
                          : const Icon(
                        Icons.check_box_outline_blank,
                        size: 24.0,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  //SpaceWidth(8),
                  Expanded(
                      child: Text(
                        "Je certifie que toutes les informations personnelles que j’ai saisies sont correctes.",
                        style: kSubtitle2.copyWith(),
                      ))
                ],
              ),
              SpaceHeight(20),
              BlocBuilder<ProfilCubit, ProfilState>(
                // buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context, state) {
                    return state.kycVerifyStatus.isSubmissionInProgress
                        ? const Center(child: AppLoadingIndicator())
                        : Center(
                      child: ButtonWidget(
                        background: AppColors.primary,
                        textColor: AppColors.white,
                        text: "Soumettre",
                        voidCallback: () async {
                          if (isChecked) {
                            if (firstImageFilePhoto != null &&
                                secondImageFilePhoto != null &&
                                _selectedPicTypeDoc != null &&
                                textEditingControllerNumber
                                    .text.isNotEmpty &&
                                textEditingControllereExpireDate
                                    .text.isNotEmpty) {
                              dio.FormData formData = dio.FormData.fromMap({
                                "photo": await dio.MultipartFile.fromFile(
                                    firstImageFilePhoto!.path),
                                "photo2": await dio.MultipartFile.fromFile(
                                    secondImageFilePhoto!.path),
                                "type": _selectedPicTypeDoc,
                                "number": textEditingControllerNumber.text,
                                "date":
                                textEditingControllereExpireDate.text,
                              });
                              context
                                  .read<ProfilCubit>()
                                  .kycVerify(data: formData);
                            } else {
                              buildWhitePopUpMessage(
                                  message:
                                  "Tout les champs sont obligatoire");
                            }
                          } else {
                            buildWhitePopUpMessage(
                                message:
                                "Veillez acceptez les conditions d'utilisation");
                          }
                        },
                      ),
                    );
                  }),

              //devenirVendeur(context),
              SpaceHeight(kBottomNavigationBarHeight),
            ],
          ),
        ),
      ],
    ); /*SingleChildScrollView(
        child: BlocConsumer<ProfilCubit, ProfilState>(builder: (context, state) {

          if(state.kycVerifyStatus.isSubmissionSuccess){
            return KycInProgress(
              texte: "Vérification client en attente",
              description: "Nous sommes toujours en train de traiter votre vérification d'identité client. Une fois que notre équipe ait vérifié votre identité, vous serez averti par e-mail. Vous pouvez également vérifier l'état de conformité de votre vérification à partir de cette page.",
            );
          }else{
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceHeight(10),
                Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            "Vérification du compte",
                            textAlign: TextAlign.center,
                            style: kHeading3,
                          ),
                          SpaceHeight(5),
                          Text(
                            "La vérification d’identité vous rend éligible aux échanges de pièces, aux promotions et aux offres",
                            style: kSubtitle2,
                          )
                        ],
                      ),
                    )),
                SpaceHeight(20),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.grey),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text("01"),
                            ),
                          ),
                          SpaceWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Document téléversé",
                                style: kHeading4,
                              ),
                              SpaceHeight(5),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  "Pour vérifier votre identité, veuillez télécharger n’importe lequel de vos documents",
                                  style: kSubtitle2,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                          ),
                          SpaceWidth(15),
                          SizedBox(
                            width: 300,
                            child: Text(
                                "Pour compléter, veuillez télécharger l’un des documents personnels suivants."),
                          )
                        ],
                      ),
                      SpaceHeight(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //ma: WrapAlignment.start,
                            children: [
                              Text(
                                "Passeport,",
                                style: kSubtitle2.copyWith(color: AppColors.error),
                              ),
                              Text(
                                "Permis de conduire,",
                                style: kSubtitle2.copyWith(color: AppColors.error),
                              ),
                              Text(
                                "Carte d'identité nationale",
                                style: kSubtitle2.copyWith(color: AppColors.error),
                              )
                            ],
                          ),
                        ],
                      ),
                      SpaceHeight(10),
                      Text(
                        "Pour éviter les retards lors de la vérification du compte, veuillez vous assurer que :",
                        style: kSubtitle2.copyWith(fontWeight: FontWeight.w800),
                      ),
                      SpaceHeight(5),
                      Text(
                        "- les informations d’identification ne sont pas expirer;",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Text(
                        "- le document doit être en bon état et clairement lisible;",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Text(
                        "- il n’y a pas des parties illisibles sur la carte;",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Text(
                        "- on a une vue d’ensemble du document",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: AppColors.grey)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              firstSelect = true;
                              secondSelect = false;
                            });
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height / 4,
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
                                                    imageSource: ImageSource.gallery),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        Icons.photo_library_outlined),
                                                    Text("Galerie")
                                                  ],
                                                )),
                                            GestureDetector(
                                                onTap: () => pickImageFromGallery(
                                                    imageSource: ImageSource.camera),
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
                                child: Text(firstPickupImage
                                    ? "${firstFileNamePhoto}"
                                    : "Téléversement de fichiers"),
                              ),
                              Icon(Icons.upload)
                            ],
                          ),
                        ),
                      ),
                      SpaceHeight(10),
                      Text(
                        "Téléchargez ici une photo de vous tenant le document",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: AppColors.grey)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              firstSelect = false;
                              secondSelect = true;
                            });
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height / 4,
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
                                                    imageSource: ImageSource.gallery),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                        Icons.photo_library_outlined),
                                                    Text("Galerie")
                                                  ],
                                                )),
                                            GestureDetector(
                                                onTap: () => pickImageFromGallery(
                                                    imageSource: ImageSource.camera),
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
                                child: Text(secondPickupImage
                                    ? "${secondImageFilePhoto}"
                                    : "Téléversement de fichiers"),
                              ),
                              //Spacer(),
                              Icon(Icons.upload)
                            ],
                          ),
                        ),
                      ),
                      SpaceHeight(10),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.grey),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text("02"),
                            ),
                          ),
                          SpaceWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Détails de l’ID",
                                style: kHeading4,
                              ),
                              SpaceHeight(5),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  "Sélectionnez le type d’ID, entrez le numéro d’IDENTIFICATION et la date d’expiration inscrit sur votre document d’identification",
                                  style: kSubtitle2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Text(
                        "Document Type ",
                        style: kSubtitle2,
                      ),
                      SpaceHeight(5),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: AppColors.grey)),
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            //fillColor: Colors.grey[300],
                          ),
                          hint: Text('Choisir...'),
                          isExpanded: true,
                          isDense: true,
                          value: _selectedPicTypeDoc,
                          selectedItemBuilder: (BuildContext context) {
                            return _picTypeDoc.map<Widget>((String item) {
                              return DropdownMenuItem(value: item, child: Text(item));
                            }).toList();
                          },
                          items: _picTypeDoc.map((item) {
                            if (item == _selectedPicTypeDoc) {
                              return DropdownMenuItem(
                                value: item,
                                child: Container(
                                    height: 48.0,
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item,
                                      ),
                                    )),
                              );
                            } else {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }
                          }).toList(),
                          //  validator: (String? value) => value?.isEmpty ?? true ? 'Cannot Empty' : null,
                          onChanged: (selectedItem) => setState(
                                () {
                              _selectedPicTypeDoc = selectedItem as String;
                            },
                          ),
                        ),
                      ),
                      SpaceHeight(10),
                      Column(
                        children: [
                          InputTextField(
                            label: "Numéro d’identification",
                            hintText: '',
                            keyboardType: TextInputType.text,
                            controller: textEditingControllerNumber,

                            //error: state.email.invalid ? 'Invalid adresse email' : null,
                            onChanged: (value) {},
                          ),
                          SpaceHeight(5),
                          Text(
                            "(Remarque : Assurez-vous d’entrer un numéro d’identification complet.",
                            style: kSubtitle2.copyWith(fontSize: 9),
                          ),
                        ],
                      ),
                      SpaceHeight(10),
                      InputTextField(
                        label: "Date d’expiration de l’ID :",
                        hintText: '',
                        keyboardType: TextInputType.text,
                        controller: textEditingControllereExpireDate,
                        readOnly: true,
                        isSuffixIcon: true,
                        suffixWidget: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                    backgroundColor: Colors.white,
                                    content: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: SfDateRangePicker(
                                        selectionColor: AppColors.primary,
                                        enablePastDates: false,
                                        //maxDate: DateTime.now(),
                                        todayHighlightColor: AppColors.primary,
                                        onSelectionChanged: _onSelectionDate,
                                        selectionMode:
                                        DateRangePickerSelectionMode.single,
                                        showActionButtons: true,
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onSubmit: (value) {
                                          Navigator.of(context).pop();
                                        },
                                        confirmText: "Select",
                                        cancelText: "Annuler",
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Icon(Icons.calendar_month),
                        ),
                        onChanged: (value) {},
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                //color: AppColors.primary,
                                borderRadius:
                                BorderRadius.all(Radius.circular(RadiusSizes.r5)),
                              ),
                              child: isChecked
                                  ? const Icon(
                                Icons.check_box,
                                size: 24.0,
                                color: AppColors.primary,
                              )
                                  : const Icon(
                                Icons.check_box_outline_blank,
                                size: 24.0,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          //SpaceWidth(8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: kSubtitle1,
                                children: [
                                  TextSpan(
                                      text:
                                      'Je suis d\'accord avec la Politique de confidentialité, ',
                                      style: kSubtitle2.copyWith()),
                                  TextSpan(
                                    text: 'les termes  & conditions ',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.offAllNamed(RoutePaths.loginScreen),
                                    style: kSubtitle2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'de Marketscc',
                                    style: kSubtitle2.copyWith(),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SpaceHeight(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                //color: AppColors.primary,
                                borderRadius:
                                BorderRadius.all(Radius.circular(RadiusSizes.r5)),
                              ),
                              child: isChecked
                                  ? const Icon(
                                Icons.check_box,
                                size: 24.0,
                                color: AppColors.primary,
                              )
                                  : const Icon(
                                Icons.check_box_outline_blank,
                                size: 24.0,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          //SpaceWidth(8),
                          Expanded(
                              child: Text(
                                "Je certifie que toutes les informations personnelles que j’ai saisies sont correctes.",
                                style: kSubtitle2.copyWith(),
                              ))
                        ],
                      ),
                      SpaceHeight(20),
                      BlocBuilder<ProfilCubit, ProfilState>(
                        // buildWhen: (previous, current) => previous.status != current.status,
                          builder: (context, state) {
                            return state.kycVerifyStatus.isSubmissionInProgress
                                ? const Center(child: AppLoadingIndicator())
                                : Center(
                              child: ButtonWidget(
                                background: AppColors.primary,
                                textColor: AppColors.white,
                                text: "Soumettre",
                                voidCallback: () async {
                                  if (isChecked) {
                                    if (firstImageFilePhoto != null &&
                                        secondImageFilePhoto != null &&
                                        _selectedPicTypeDoc != null &&
                                        textEditingControllerNumber
                                            .text.isNotEmpty &&
                                        textEditingControllereExpireDate
                                            .text.isNotEmpty) {
                                      dio.FormData formData = dio.FormData.fromMap({
                                        "photo": await dio.MultipartFile.fromFile(
                                            firstImageFilePhoto!.path),
                                        "photo2": await dio.MultipartFile.fromFile(
                                            secondImageFilePhoto!.path),
                                        "type": _selectedPicTypeDoc,
                                        "number": textEditingControllerNumber.text,
                                        "date":
                                        textEditingControllereExpireDate.text,
                                      });
                                      context
                                          .read<ProfilCubit>()
                                          .kycVerify(data: formData);
                                    } else {
                                      buildWhitePopUpMessage(
                                          message:
                                          "Tout les champs sont obligatoire");
                                    }
                                  } else {
                                    buildWhitePopUpMessage(
                                        message:
                                        "Veillez acceptez les conditions d'utilisation");
                                  }
                                },
                              ),
                            );
                          }),

                      //devenirVendeur(context),
                      SpaceHeight(kBottomNavigationBarHeight),
                    ],
                  ),
                ),
              ],
            );
          }
    }, listener: (context, state) {

    }));*/
  }

  Future<void> pickImageFromGallery({required ImageSource imageSource}) async {
    request();
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (firstSelect) {
      firstImageFilePhoto =
          (pickedImage != null ? File(pickedImage.path) : null)!;
      if (firstImageFilePhoto != null) {
        setState(() {
          isValidePhoto = true;
          firstPickupImage = true;
          firstFileNamePhoto = firstImageFilePhoto!.path.split('/').last;
          Navigator.of(context).pop();
        });
      }
    } else if (secondSelect) {
      secondImageFilePhoto =
          (pickedImage != null ? File(pickedImage.path) : null)!;
      if (secondImageFilePhoto != null) {
        setState(() {
          isValidePhoto = true;
          secondPickupImage = true;
          secondFileNamePhoto = secondImageFilePhoto!.path.split('/').last;
          Navigator.of(context).pop();
        });
      }
    }
  }

  void _onSelectionDate(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedExpireDate = args.value.toString();
      textEditingControllereExpireDate.text =
          DateFormat.yMd("fr").format(DateTime.parse(args.value.toString()));
      dateEmpty = false;
    });
  }
}

void request() async {
  log("je sios ici");
  if (await Permission.photos.request().isDenied ||
      await Permission.camera.request().isDenied) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.camera,
    ].request();
    print(statuses[Permission.location]);
  }
}
