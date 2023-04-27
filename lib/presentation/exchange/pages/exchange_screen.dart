import 'package:flutter/gestures.dart';
import 'package:marketscc/data/models/user_model.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../export.dart';


class ExchangeScreen extends StatefulWidget {

  const ExchangeScreen({
    Key? key, required this.annonceModel,
  }) : super(key: key);

  final AnnonceModel annonceModel;

  @override
  ExchangeScreenState createState() => ExchangeScreenState();
}

class ExchangeScreenState extends State<ExchangeScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  TextEditingController amountGetController = TextEditingController();
  TextEditingController reserveController = TextEditingController();


  //late UserModel user;
  WalletUser? selectWalletUser;

  double reserveReste=0;

  late List<WalletUser> wallet=[];
  @override
  void initState() {

    selectWalletUser = context.read<ProfilCubit>().getUser!.wallet!.firstWhereOrNull((element) => element.currency!.id==int.parse(widget.annonceModel.giveId!));

    super.initState();
  }

  void _clearAll() {
    amountGetController.text = "";
    reserveController.text = "";
  }

  void _cryptoChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double amountGive = double.parse(text);
    double prixget  = (amountGive * double.parse(widget.annonceModel.qgive!)) / double.parse(widget.annonceModel.qget!);
    amountGetController.text = prixget.toString();
    reserveReste  = double.parse(widget.annonceModel.reserve!)-prixget;
    if(reserveReste<0){
      reserveController.text = "0";
    }else{
      reserveController.text = reserveReste.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: AppColors.white,
        body:SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          InputTextField(
            label: "Donner : ${widget.annonceModel.getSymbol} ",
            hintText: '0.0',
            //keyboardType: TextInputType.number,
            controller: amountController,
            error:  null,
            inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value){
              _cryptoChanged(value);
            },
          ),
          const SpaceHeight(10),
          InputTextField(
            label: "Vous recevez : ${widget.annonceModel.giveSymbol}",
            hintText: '0.0',
            keyboardType: TextInputType.number,
            controller: amountGetController,
            readOnly: true,
            error:  null,
            onChanged: (value){},
          ),
          const SpaceHeight(10),
          InputTextField(
            label: "Réserve du revendeur : ${widget.annonceModel.giveSymbol}",
            hintText: '0.0',
            keyboardType: TextInputType.text,
            controller: reserveController,
            readOnly: true,
            error:  null,
            onChanged: (value){},
          ),
            reserveReste<0?Text("Reste terminer"):Container(),
          const SpaceHeight(10),

            InputTextField(
              label: "Adresse portefeuille ${widget.annonceModel.giveSymbol}",
              hintText: selectWalletUser?.address==null? "":"${selectWalletUser?.address}",
              keyboardType: TextInputType.text,
              readOnly: true,
              error:  null,
              onChanged: (value){},
            ),
          Visibility(visible: selectWalletUser==null, child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SpaceHeight(5),
            Text("Assurez-vous d'avoir choisit la bonne adresse", style: kSubtitle2,),
            const SpaceHeight(5),
            Text.rich( TextSpan(children: [
              TextSpan(text: "Si inexistant, veillez l'ajouter d'abord dans", children: [
              TextSpan(text: " Mes portefeuilles",
                style: kSubtitle2.copyWith(color: AppColors.error),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                    context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.profil);
                  }),
              ]),
            ]),
              style: kSubtitle2,
            )
          ],)),
          const SpaceHeight(10),
          InputTextField(
            label: "Commentaire/Instruction",
            hintText: 'Message',
            keyboardType: TextInputType.text,
            controller: commentaireController,
            maxline: 5,
            minline: 3,
            error:  null,
            onChanged: (value){},
          ),
          const SpaceHeight(20),
         Center(child:  ButtonWidget(
             background: AppColors.primary,
             textColor: AppColors.white,
             text: "Acheter",
             voidCallback: () {
               if(selectWalletUser!=null && amountController.text.isNotEmpty){
                 Get.toNamed(RoutePaths.resumeExchange, arguments:ExchangeBuyCoin(trId: widget.annonceModel.trId, quantityToExchange: amountController.text, annonceModel: widget.annonceModel, walletUser: selectWalletUser, text: commentaireController.text));
               }else if(selectWalletUser==null){
                 buildWhitePopUpMessage(message: 'Adresse portefeuille ou Numéro est obligatoire');
               }else{
                 buildWhitePopUpMessage(message: 'La quantité de ${widget.annonceModel.getSymbol} est obligatoire');
               }
             }
         ),)
        ],),),));
  }
}




class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    } else if (value.contains(".")) {
      String tempValue = value.substring(value.indexOf(".") + 1);
      if (tempValue.contains(".")) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
      if (value.indexOf(".") == 0) {
        truncated = "0" + truncated;
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }
    }
    if (value.contains(" ") || value.contains("-")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

