import 'package:flutter/material.dart';

import '../../../export.dart';

Future<void> popup(context){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Container(
            height: 220,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Documents pour vérification de compte revendeur", style: kSubtitle2.copyWith(fontWeight: FontWeight.w700),),
              SpaceHeight(20),
              Text("Vos documents a envoyé par mail : contact@marketscc.com", style: kSubtitle2.copyWith(fontWeight: FontWeight.w700)),
              SpaceHeight(20),
              Text("CIP (pour résident au Bénin)"),
              SpaceHeight(10),
              Text("Attestation de résidence d’attend d’au moins 1 mois"),
              SpaceHeight(10),
              Text("Photo complète"),

            ],),),);
      });
}