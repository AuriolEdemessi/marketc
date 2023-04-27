import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import '../../../export.dart';

class CustomCompteActive extends StatefulWidget {
  const CustomCompteActive({Key? key}) : super(key: key);

  @override
  State<CustomCompteActive> createState() => _CustomCompteActiveState();
}

class _CustomCompteActiveState extends State<CustomCompteActive> {
   bool showForm = false;
   File? firstPick;
   File? secondPick;
   File? thirdPick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        Icon(Icons.warning_amber, size: 70,),
        SpaceHeight(10),
        Text("Vous avez terminé le processus de vérification client", textAlign: TextAlign.center, style: kHeading3,),
        SpaceHeight(10),
        Text("Vous pouvez maintenant acheter des devises sur nos plateformes", textAlign: TextAlign.center, style: kHeading4.copyWith(color: AppColors.error)),
        SpaceHeight(10),
        Text("Merci d'avoir choisi Cryptocurrency Markets.", textAlign: TextAlign.center, style: kHeading4),
        SpaceHeight(10),
        Divider(
          color: AppColors.black,
        ),
        Text("Devenir revendeur ?", textAlign: TextAlign.center,style: kHeading3.copyWith(color: AppColors.error)),
        SpaceHeight(10),
        Text("Pour devenir revendeur vous devriez fournir quelques documents complémentaires", textAlign: TextAlign.center, style: kHeading4),
        SpaceHeight(10),
        Text("Après vérification, votre compte sera automatiquement porté au grade de revendeur / marchand", textAlign: TextAlign.center, style: kHeading4),
        SpaceHeight(10),
        Text.rich(TextSpan(
            text: "Vous auriez donc la possibilité de publier aussi des offres d'échange ", style: kHeading4.copyWith(color: AppColors.error),
            children: [

            ]
        ),
          textAlign: TextAlign.center,
        ),
        SpaceHeight(10),
        Visibility(
          visible: !showForm,
          child: Column(
            children: [
              ButtonWidget(
                width: double.infinity,
                background:AppColors.primary,
                textColor: AppColors.white,
                text: "Voir la liste des documents à envoyer",
                voidCallback: (){
                  setState(() {
                    showForm = true;
                  });
                },
              ),
            ],
          ),
        ),
        Visibility(
          visible: showForm,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("CIP (pour résident au Bénin)", style: kSubtitle2,),
              SpaceHeight(5),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)
                ),
                child: InkWell(
                  onTap: (){
                    buildBottomSheetPickup(context, onPickFile:(file){
                      setState(() {
                        firstPick = file;
                      });
                    });
                  },
                  child: Row(children: [
                    Expanded(child: Text(firstPick!=null?"${firstPick!.path.split('/').last}":"Téléversement de fichiers"),),
                    Icon(Icons.upload)
                  ],),
                ),
              ),
              SpaceHeight(10),
              Text("Attestation de résidence d’attend d’au moins 1 mois", style: kSubtitle2,),
              SpaceHeight(5),

              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)
                ),
                child: InkWell(
                  onTap: (){
                    buildBottomSheetPickup(context, onPickFile:(file){
                      setState(() {
                        secondPick = file;
                      });
                    });
                  },
                  child: Row(children: [
                    Expanded(child: Text(secondPick!=null?"${secondPick!.path.split('/').last}":"Téléversement de fichiers"),),
                    Icon(Icons.upload)
                  ],),
                ),
              ),
              SpaceHeight(10),

              Text("Photo complète", style: kSubtitle2,),
              SpaceHeight(5),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.grey)
                ),
                child: InkWell(
                  onTap: (){
                    buildBottomSheetPickup(context, onPickFile:(file){

                      setState(() {
                        thirdPick = file;
                      });
                    });

                  },
                  child: Row(children: [
                    Expanded(child: Text(thirdPick!=null?"${thirdPick!.path.split('/').last}":"Téléversement de fichiers"),),
                    Icon(Icons.upload)
                  ],),
                ),
              ),

              SpaceHeight(20),
              BlocBuilder<ProfilCubit, ProfilState>(
                // buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context, state) {
                    return state.revendeurVerifyStatus.isSubmissionInProgress
                        ? const Center(child: AppLoadingIndicator()): Center(child: ButtonWidget(
                      background:AppColors.primary,
                      textColor: AppColors.white,
                      text: "Envoyer",
                      voidCallback: () async{
                        if(firstPick!=null && thirdPick!=null && secondPick!=null){
                          dio.FormData formData = dio.FormData.fromMap({
                            "cip": await dio.MultipartFile.fromFile(firstPick!.path),
                            "attestationresidence":await dio.MultipartFile.fromFile(secondPick!.path),
                            "photo":await dio.MultipartFile.fromFile(thirdPick!.path),
                          });
                          context.read<ProfilCubit>().verifyRevendeur(data: formData);
                        }else{
                          buildWhitePopUpMessage(message: "Tout les champs sont obligatoire");
                        }
                      },
                    ),);
                  }
              ),

            ],),
        ),
        SpaceHeight(kToolbarHeight)
      ],),
    ); /*SingleChildScrollView(child:
    BlocBuilder<ProfilCubit, ProfilState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state){
        if(state.revendeurVerifyStatus.isSubmissionSuccess){
          return statusWidget(state.userResponse?.user?.verified);
        }else{
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              Icon(Icons.warning_amber, size: 70,),
              SpaceHeight(10),
              Text("Vous avez terminé le processus de vérification client", textAlign: TextAlign.center, style: kHeading3,),
              SpaceHeight(10),
              Text("Vous pouvez maintenant acheter des devises sur nos plateformes", textAlign: TextAlign.center, style: kHeading4.copyWith(color: AppColors.error)),
              SpaceHeight(10),
              Text("Merci d'avoir choisi Cryptocurrency Markets.", textAlign: TextAlign.center, style: kHeading4),
              SpaceHeight(10),
              Divider(
                color: AppColors.black,
              ),
              Text("Devenir revendeur ?", textAlign: TextAlign.center,style: kHeading3.copyWith(color: AppColors.error)),
              SpaceHeight(10),
              Text("Pour devenir revendeur vous devriez fournir quelques documents complémentaires", textAlign: TextAlign.center, style: kHeading4),
              SpaceHeight(10),
              Text("Après vérification, votre compte sera automatiquement porté au grade de revendeur / marchand", textAlign: TextAlign.center, style: kHeading4),
              SpaceHeight(10),
              Text.rich(TextSpan(
                  text: "Vous auriez donc la possibilité de publier aussi des offres d'échange ", style: kHeading4.copyWith(color: AppColors.error),
                  children: [

                  ]
              ),
                textAlign: TextAlign.center,
              ),
              SpaceHeight(10),
              Visibility(
                visible: !showForm,
                child: Column(
                  children: [
                    ButtonWidget(
                      width: double.infinity,
                      background:AppColors.primary,
                      textColor: AppColors.white,
                      text: "Voir la liste des documents à envoyer",
                      voidCallback: (){
                        setState(() {
                          showForm = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showForm,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("CIP (pour résident au Bénin)", style: kSubtitle2,),
                    SpaceHeight(5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: AppColors.grey)
                      ),
                      child: InkWell(
                        onTap: (){
                          buildBottomSheetPickup(context, onPickFile:(file){
                            setState(() {
                              firstPick = file;
                            });
                          });
                        },
                        child: Row(children: [
                          Expanded(child: Text(firstPick!=null?"${firstPick!.path.split('/').last}":"Téléversement de fichiers"),),
                          Icon(Icons.upload)
                        ],),
                      ),
                    ),
                    SpaceHeight(10),
                    Text("Attestation de résidence d’attend d’au moins 1 mois", style: kSubtitle2,),
                    SpaceHeight(5),

                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: AppColors.grey)
                      ),
                      child: InkWell(
                        onTap: (){
                          buildBottomSheetPickup(context, onPickFile:(file){
                            setState(() {
                              secondPick = file;
                            });
                          });
                        },
                        child: Row(children: [
                          Expanded(child: Text(secondPick!=null?"${secondPick!.path.split('/').last}":"Téléversement de fichiers"),),
                          Icon(Icons.upload)
                        ],),
                      ),
                    ),
                    SpaceHeight(10),

                    Text("Photo complète", style: kSubtitle2,),
                    SpaceHeight(5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: AppColors.grey)
                      ),
                      child: InkWell(
                        onTap: (){
                          buildBottomSheetPickup(context, onPickFile:(file){

                            setState(() {
                              thirdPick = file;
                            });
                          });

                        },
                        child: Row(children: [
                          Expanded(child: Text(thirdPick!=null?"${thirdPick!.path.split('/').last}":"Téléversement de fichiers"),),
                          Icon(Icons.upload)
                        ],),
                      ),
                    ),

                    SpaceHeight(20),
                    BlocBuilder<ProfilCubit, ProfilState>(
                      // buildWhen: (previous, current) => previous.status != current.status,
                        builder: (context, state) {
                          return state.revendeurVerifyStatus.isSubmissionInProgress
                              ? const Center(child: AppLoadingIndicator()): Center(child: ButtonWidget(
                            background:AppColors.primary,
                            textColor: AppColors.white,
                            text: "Envoyer",
                            voidCallback: () async{
                              if(firstPick!=null && thirdPick!=null && secondPick!=null){
                                dio.FormData formData = dio.FormData.fromMap({
                                  "cip": await dio.MultipartFile.fromFile(firstPick!.path),
                                  "attestationresidence":await dio.MultipartFile.fromFile(secondPick!.path),
                                  "photo":await dio.MultipartFile.fromFile(thirdPick!.path),
                                });
                                context.read<ProfilCubit>().verifyRevendeur(data: formData);
                              }else{
                                buildWhitePopUpMessage(message: "Tout les champs sont obligatoire");
                              }
                            },
                          ),);
                        }
                    ),

                  ],),
              ),
              SpaceHeight(kToolbarHeight)
            ],),
          );
        }
      },
    ),)*/;
  }
}
