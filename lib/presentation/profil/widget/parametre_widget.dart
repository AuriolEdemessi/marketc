import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../export.dart';

class ParametreWidget extends StatefulWidget {
  final UserResponse userData;

  ParametreWidget({required this.userData});

  @override
  State<ParametreWidget> createState() => ParametreWidgetState();
}

class ParametreWidgetState extends State<ParametreWidget> {
  late TextEditingController nomTextEditingController;
  late TextEditingController prenomTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController numeroTextEditingController;
  late TextEditingController paysTextEditingController;
  late TextEditingController adressTextEditingController;
  late TextEditingController villeTextEditingController;
  late TextEditingController phoneIndicatifTextEditingController;
  late TextEditingController dateNaissanceTextEditingController;

  TextEditingController passwordTextEditingController = TextEditingController();


  late CountryCode countryCode;

  bool seeAll = false;

  String selectedBirthdateDate = "";
  bool ageIsEmpty = false;

  File? imageFilePhoto;
  String? fileNamePhoto;
  bool isValidePhoto = false;
  bool pickupImage = false;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    nomTextEditingController =
        TextEditingController(text: widget.userData.user?.lname);
    prenomTextEditingController =
        TextEditingController(text: widget.userData.user?.fname);
    emailTextEditingController =
        TextEditingController(text: widget.userData.user?.email);
    numeroTextEditingController =
        TextEditingController(text: widget.userData.user?.phone);
    paysTextEditingController =
        TextEditingController(text: widget.userData.user?.country);
    adressTextEditingController =
        TextEditingController(text: widget.userData.user?.address);
    villeTextEditingController =
        TextEditingController(text: widget.userData.user?.city);
    phoneIndicatifTextEditingController =
        TextEditingController(text: widget.userData.user?.phoneIndicatif);
    dateNaissanceTextEditingController =
        TextEditingController(text: widget.userData.user?.dob);
    countryCode = CountryCode(
        name: "", code: widget.userData.user?.country, dialCode: "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilCubit, ProfilState>(
      listener: (context, state) {
        if (state.updateStatus.isSubmissionSuccess) {
          buildWhitePopUpMessage(
              message: "Votre profil a été mis à jour avec succés.");
        } else if (state.updateStatus.isSubmissionFailure) {
          String message = "";
          state.message?.errors!.forEach((element) {
            message += "$element\n";
          });
          buildWhitePopUpMessage(
              message: message.isEmpty ? state.message!.release! : message);
        }else if(state.deleteStatus.isSubmissionInProgress){
          openLoadingDialog();
        }else if(state.deleteStatus.isSubmissionSuccess){
          getX.Get.back();
          getX.Get.back();
          Future.delayed(const Duration(milliseconds: 500), () {
            context.read<ProfilCubit>().setUserData(null);
            buildWhitePopUpMessage(message: '${state.sucessMessage?.message?? state.message!.release!}');
            getX.Get.offAllNamed(RoutePaths.loginScreen);
          });
        }else if(state.deleteStatus.isSubmissionFailure){
          String message = "";
          state.message?.errors!.forEach((element) {
            message += "$element\n";
          });
          getX.Get.back();
          buildWhitePopUpMessage(
              message: message.isEmpty ? state.message!.release! : message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
            child: Column(
          children: [
            const SpaceHeight(10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: InputTextField(
                label: "Prénom",
                hintText: 'Prénom',
                keyboardType: TextInputType.text,
                controller: prenomTextEditingController,
                error: null,
                onChanged: (value) => context
                    .read<LoginCubit>()
                    .textFieldsChanged(
                        value = '${{widget.userData.user?.fname}}'),
              ),
            ),
            const SpaceHeight(10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: InputTextField(
                label: "Nom",
                hintText: 'Nom',
                controller: nomTextEditingController,
                keyboardType: TextInputType.text,
                error: null,
                onChanged: (value) =>
                    context.read<LoginCubit>().textFieldsChanged(value),
              ),
            ),
            const SpaceHeight(10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: InputTextField(
                label: "Adresse Email",
                hintText: 'Adresse Email',
                controller: emailTextEditingController,
                keyboardType: TextInputType.text,
                error: null,
                onChanged: (value) {},
              ),
            ),
            const SpaceHeight(10),
            PhoneNumberdInput(
              edgeInsets: EdgeInsets.only(left: 10, right: 10),
              label: "Numéro de télephone",
              code: phoneIndicatifTextEditingController.text,
              hintText: '97979797',
              onChanged: (CountryCode? code) {
                setState(() {
                  // countryCode = code!.code!;
                  phoneIndicatifTextEditingController.text = code!.dialCode!;
                  countryCode = code;
                });
              },
              textEditingController: numeroTextEditingController,
            ),
            const SpaceHeight(10),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      seeAll = !seeAll;
                    });
                  },
                  child: Text(
                    seeAll ? "Voir moin" : "Voir tout",
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
            Visibility(
                visible: seeAll,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InputTextField(
                        label: "Pays",
                        hintText: 'Pays',
                        controller: paysTextEditingController,
                        keyboardType: TextInputType.text,
                        error: null,
                        onChanged: (value) =>
                            context.read<LoginCubit>().textFieldsChanged(value),
                      ),
                    ),
                    const SpaceHeight(10),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InputTextField(
                        label: "Addresse",
                        hintText: 'Addresse',
                        controller: adressTextEditingController,
                        keyboardType: TextInputType.text,
                        error: null,
                        onChanged: (value) =>
                            context.read<LoginCubit>().textFieldsChanged(value),
                      ),
                    ),
                    const SpaceHeight(10),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InputTextField(
                        label: "Ville",
                        hintText: 'Ville',
                        controller: villeTextEditingController,
                        keyboardType: TextInputType.text,
                        error: null,
                        onChanged: (value) =>
                            context.read<LoginCubit>().textFieldsChanged(value),
                      ),
                    ),
                    const SpaceHeight(10),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InputTextField(
                        label: "Date de naissance",
                        hintText: 'Date de naissance',
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    backgroundColor: Colors.white,
                                    content: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: SfDateRangePicker(
                                        selectionColor: AppColors.primary,
                                        enablePastDates: true,
                                        maxDate: DateTime.now(),
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
                        controller: dateNaissanceTextEditingController,
                        keyboardType: TextInputType.text,
                        error: null,
                        onChanged: (value) {},
                      ),
                    ),
                    const SpaceHeight(10),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InputTextField(
                        label: "Photo de profile",
                        hintText:
                            '${pickupImage ? "${fileNamePhoto}" : "Téléversement de fichiers"}',
                        keyboardType: TextInputType.text,
                        error: null,
                        readOnly: true,
                        isSuffixIcon: true,
                        suffixWidget: InkWell(
                          onTap: () {
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
                                                onTap: () =>
                                                    pickImageFromGallery(
                                                        imageSource: ImageSource
                                                            .gallery),
                                                child: Column(
                                                  children: [
                                                    Icon(Icons
                                                        .photo_library_outlined),
                                                    Text("Galerie")
                                                  ],
                                                )),
                                            GestureDetector(
                                                onTap: () =>
                                                    pickImageFromGallery(
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
                          child: Icon(Icons.upload),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SpaceHeight(30),
                  ],
                )),
            Center(
              child: state.updateStatus.isSubmissionInProgress
                  ? AppLoadingIndicator()
                  : ButtonWidget(
                      background: AppColors.primary,
                      textColor: AppColors.white,
                      text: "Mettre a jour",
                      voidCallback: () async {
                        if (pickupImage) {
                          String fileName =
                              imageFilePhoto!.path.split('/').last;
                          FormData formData = FormData.fromMap({
                            "image": await MultipartFile.fromFile(
                                imageFilePhoto!.path,
                                filename: fileName),
                            "fname": prenomTextEditingController.text,
                            "lname": nomTextEditingController.text,
                            "email": emailTextEditingController.text,
                            "phone": numeroTextEditingController.text,
                            "dob": dateNaissanceTextEditingController.text,
                            "address": adressTextEditingController.text,
                            "city": villeTextEditingController.text,
                            "zip_code": phoneIndicatifTextEditingController.text,
                            "country": paysTextEditingController.text,
                            "phone_indicatif": phoneIndicatifTextEditingController.text,
                          });

                          context
                              .read<ProfilCubit>()
                              .updateUser(data: formData);
                        } else {
                          Map<String, dynamic> jsonBody = {
                            "fname": prenomTextEditingController.text,
                            "lname": nomTextEditingController.text,
                            "email": emailTextEditingController.text,
                            "phone": numeroTextEditingController.text,
                            "dob": dateNaissanceTextEditingController.text,
                            "address": adressTextEditingController.text,
                            "city": villeTextEditingController.text,
                            "zip_code": phoneIndicatifTextEditingController.text,
                            "phone_indicatif": phoneIndicatifTextEditingController.text,
                            "country": paysTextEditingController.text,
                          };
                          context
                              .read<ProfilCubit>()
                              .updateUser(data: jsonBody);
                        }
                      },
                    ),
            ),
            const SpaceHeight(30),
            Center(
                child: ButtonWidget(
                  text: "Supprimer mon compte",
                  textColor: AppColors.white,
                  background: AppColors.error,
                  voidCallback: (){
                    customAlertDialog(
                        child: Text("Voulez vous supprimer votre compte?", style: kSubtitle1,),
                        yesAction: (){
                          getX.Get.back();
                          customAlertDialog(
                            yesText: 'Confirmer',
                            noText: 'Annuler',
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                Text("Entrez votre mot de passe pour confirmer", style: kSubtitle1,),

                                Padding(
                              padding: EdgeInsets.only(left: 29.w, right: 29.w),
                              child: InputTextField(
                                label: "",
                                hintText: '',
                                isSuffixIcon: true,
                                obscureText: obscureText,
                                error: null,
                                keyboardType: TextInputType.text,
                                controller: passwordTextEditingController,
                                onChanged: (value) {},
                              ),
                            )

                              ],),
                              yesAction: (){
                                //getX.Get.back();
                                if(passwordTextEditingController.text.isEmpty){
                                  buildWhitePopUpMessage(message: "Mot de passe incorrect");
                                }else{
                                  context.read<ProfilCubit>().deletedUser(data: passwordTextEditingController.text);
                                }
                              },
                              noAction: (){
                                getX.Get.back();
                              }
                          );
                          //context.read<AnnonceCubit>().deleteAnnonceById(item.trId);
                        },
                        noAction: (){
                          getX.Get.back();
                        }
                    );
                  },
                )),
            const SpaceHeight(120)
          ],
        ));
      },
    );
  }

  void _onSelectionDate(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedBirthdateDate = args.value.toString();
      dateNaissanceTextEditingController.text =
          DateFormat.yMd("fr").format(DateTime.parse(args.value.toString()));
      ageIsEmpty = false;
    });
  }

  Future<void> pickImageFromGallery({required ImageSource imageSource}) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    imageFilePhoto = (pickedImage != null ? File(pickedImage.path) : null)!;
    if (imageFilePhoto != null) {
      setState(() {
        isValidePhoto = true;
        pickupImage = true;
        fileNamePhoto = imageFilePhoto!.path.split('/').last;
        Navigator.of(context).pop();
      });
    }
  }
}

class _PasswordInputField extends StatefulWidget {
  const _PasswordInputField({
    Key? key,
  }) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<_PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 29.w, right: 29.w),
          child: InputTextField(
            label: "Mot de passe",
            hintText: '',
            isSuffixIcon: true,
            obscureText: obscureText,
            suffixWidget: IconButton(
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            error: state.password.invalid ? 'Invalid password' : null,
            keyboardType: TextInputType.text,
            onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
          ),
        );
      },
    );
  }
}