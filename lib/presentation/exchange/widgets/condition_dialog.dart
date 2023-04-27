import 'package:marketscc/export.dart';
import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(

       // insetPadding:EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Le paiement doit provenir de votre propre compte portant les mêmes noms enregistrés avec Cryptocurrency Markets. Le paiement par des tiers par virement Internet, transfert mobile et autres moyens électroniques n’est pas autorisé. Le paiement par un tiers sera remboursé avec divers frais appliqués et l’annulation du paiement par un tiers implique un long processus qui peut prendre parfois plusieurs semaines.", style: kSubtitle2,),
                SpaceHeight(10),
                Text("Nous pouvons demander plus de documents comme preuve que l’argent a été payé par vous-même. Donc, vous devez être prêt à les soumettre s’ils sont demandés.", style: kSubtitle2,),
                SpaceHeight(10),
                Text("N’écrivez aucun de ces mots « Bitcoin, Ethereum, Bitcoin Cash, Litecoin, Perfect Money, WebMoney, e-currency, monnaie numérique, etc. » comme nom des déposants lors du paiement par dépôt en espèces ou en tant que motif du paiement en cas de transfert Internet, de transfert mobile et autres moyens électroniques. Si vous enfreignez cette règle, votre compte peurrait être suspendu.", style: kSubtitle2),
                SpaceHeight(10),
                Text("Cryptocurrency Markets ne peut être RESPONSABLE du financement d’un mauvais COMPTE ou PORTEFEUILLE fourni par vous même. Merci de bien vérifier.", style: kSubtitle2),
                SpaceHeight(10),
                Text("Assurez-vous de vérifier et de lire régulièrement la page de facturation et votre e-mail pour nos coordonnées de paiement, car elles peuvent être modifiées à tout moment. Le paiement sur l’un de nos anciens comptes / retirés de la liste ne sera pas traité.", style: kSubtitle2),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ButtonWidget(
                      background:  AppColors.primary,
                      textColor: AppColors.white,
                      text: "D'accord",
                      voidCallback: (){
                        Navigator.pop(context);
                  },),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
