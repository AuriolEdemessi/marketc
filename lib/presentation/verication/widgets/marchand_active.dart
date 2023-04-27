import 'package:flutter/material.dart';

import '../../../export.dart';

class MarchandActive extends StatelessWidget {

  const MarchandActive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,  vertical: 150),
      child: Column( children: [
        SpaceHeight(20),
        Text("Vérification terminée", textAlign: TextAlign.center, style: kHeading2),
        SpaceHeight(10),
        Icon(Icons.warning_amber, size: 70,),
        SpaceHeight(10),
        Text.rich(TextSpan(
            text: "Vous avez terminé le processus de vérification marchand. ", style: kHeading4.copyWith(),
            children: [
              TextSpan(text: "Votre compte revendeur a été vérifié.", style: kHeading4.copyWith(color: AppColors.error)),
              TextSpan(text: " Vous pouvez maintenant postez des offres d'exchanges. Merci d’avoir choisi Cryptocurrency Markets.", style: kHeading4),
            ]
        ),
          textAlign: TextAlign.center,
        ),
      ],),
    ),);


  }


}
