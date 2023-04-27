import 'package:marketscc/infrastructure/styles/styles.dart';
import 'package:flutter/material.dart';

class KycInProgress extends StatelessWidget {
  final String texte;
  final String description;
  const KycInProgress({Key? key, required this.texte, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 150),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Icon(Icons.warning_amber, size: 70,),
          SpaceHeight(10),
          Text(texte, style: kHeading3.copyWith(fontWeight: FontWeight.w700),),
          SpaceHeight(20),
          Text(description,textAlign: TextAlign.center, style: kHeading4,),
        ],),
      ),
    );
  }
}
