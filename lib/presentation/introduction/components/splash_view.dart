import 'package:flutter/material.dart';

import '../../../export.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final introductionanimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0)).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: introductionanimation,
      child: Center(child: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceHeight(42),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(image: AppAssets.imgLogo512, width: 200.w, height: 200.w,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Bienvenue sur Marketscc",
                style: kHeading2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                "La plateforme d'exchange P2P qui vous  permet d'effectuer vos opérations de cryptos chez le marchand de votre choix",
                style: kSubtitle1,
                textAlign: TextAlign.center,
              ),
            ),
            const SpaceHeight(48),
            ButtonWidget(
              background: AppColors.primary,
              text: "Premier Pas",
              voidCallback: (){
                widget.animationController.animateTo(0.2);
              },
            ),
          ],
        ),
      ),),
    );
  }
}
