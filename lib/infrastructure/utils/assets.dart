import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String getPathIcon(String name) {
  return "assets/icons/$name";
}

class GetPathImage extends AssetImage {
  const GetPathImage(String fileName) : super('assets/images/$fileName');
}

class AppAssets {
  // svg
  static String icLogo = getPathIcon('logo.svg');
  static String icGraphe = getPathIcon('graphe.svg');
  static String icBg = getPathIcon('bg.svg');


  //image
  static const imgLogo =  GetPathImage('logo.png');
  static const imgBackgroud =  GetPathImage('backgroud.png');
  static const imgGraphe =  GetPathImage('graphe.png');
  static const imgLogo512 =  GetPathImage('logo_512.png');
  static const imgHome =  GetPathImage('ic_bank.png');
  static const imgAnnonce =  GetPathImage('ic_data_analysis.png');
  static const imgHistorique =  GetPathImage('ic_currency.png');
  static const imgPending =  GetPathImage('ic_invoice.png');
  static const imgProfil =  GetPathImage('profil.png');
  static const imgAide =  GetPathImage('aide.png');
  static const imgFeedback =  GetPathImage('feedback.png');
  static const imgFaq =  GetPathImage('ic_faq.png');
  static const imgShare =  GetPathImage('ic_invite.png');
  static const imgAbout =  GetPathImage('ic_about.png');
  static const imgKyc =  GetPathImage('ic_card.png');
  static const imgRate =  GetPathImage('ic_rate.png');
  static const imgExchange =  GetPathImage('ic_currency_exchange.png');
  static const imgAnnonce2 =  GetPathImage('ic_bar_graph.png');


  static Future precacheAssets(context) async {
    // svg
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, icLogo), null);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, icGraphe), null);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, icBg), null);


    //image
    await precacheImage(imgLogo, context);
    await precacheImage(imgBackgroud, context);
    await precacheImage(imgLogo512, context);
    await precacheImage(imgHome, context);
    await precacheImage(imgAnnonce, context);
    await precacheImage(imgHistorique, context);
    await precacheImage(imgPending, context);
    await precacheImage(imgFeedback, context);
    await precacheImage(imgShare, context);
    await precacheImage(imgAbout, context);
    await precacheImage(imgRate, context);

  }

}
