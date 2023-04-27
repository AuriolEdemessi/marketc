import 'package:flutter/material.dart';

import '../../../export.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    Key? key,
  }) : super(key: key);

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              Text("Cryptocurrency Markets est une plate-forme semi-automatique qui rationalise l'échange d'une monnaie numérique à une autre monnaie numérique en très peu de temps de 5 minutes à 2 heures maximum en fonction du type d'échange dont vous avez besoin. \n", style: kHeading4),
              Text("Elle regroupe plusieurs marchands de l'Afrique. La plate-forme fonctionne 24 heures sur 24, 7 jours sur 7. \n", style: kHeading4),
              Text("Vous pouvez échanger Bitcoin, Tether, PerfectMoney ou l'Ethereum en d'autres monnaies ou en argent liquide dans votre compte mobile soit sur votre compte bancaire dans n'importe quel pays. \n", style: kHeading4),
              Text("Vous pouvez également acheter Bitcoin, Tether, PerfectMoney, Ethereum et autres chez nous en espèces depuis votre compte mobile. \n", style: kHeading4),
              Text("Il suffit de sélectionner la direction de l'échange, faire le choix du marchand et de suivre les instructions. \n", style: kHeading4),
              Text("La majorité de nos clients proviennent de références d'autres clients, ce qui nous donne une grande fierté. \n", style: kHeading4),
              Text("Nous avons bâti notre réputation à temps grâce à la qualité du service. \n", style: kHeading4),
              Text("Jetez un œil aux témoignages postés par nos clients. Nous avons construit un système qui nous permet d'assurer que nous prenons le plus grand soin de sécuriser et de protéger votre vie privée et votre sécurité. \n", style: kHeading4),
             /* Row(
               // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Expanded(child: Row(
                  children: [
                    Icon(Icons.add_a_photo_outlined),
                    Expanded(child: Text("Echange de crypto-monnaie sécurisé et infaillible", style: kHeading4)),
                  ],
                ),),
                Expanded(child: Row(
                  children: [
                    Icon(Icons.add_a_photo_outlined),
                    Expanded(child: Text("Transactions sécurisées", style: kHeading4),)
                  ],
                ),)
              ],) ,
              SpaceHeight(20),
              Row(children: [
                Expanded(child: Row(children: [
                  Icon(Icons.add_a_photo_outlined),
                  Expanded(child: Text("Echange de crypto-monnaie sécurisé et infaillible", style: kHeading4))
                ],)),
                Expanded(child:Row(children: [
                  Icon(Icons.add_a_photo_outlined),
                  Expanded(child: Text("Transactions sécurisées", style: kHeading4))
                ],)),
              ],),*/
              SpaceHeight(kToolbarHeight),
            ],)),
        ));
  }
}
