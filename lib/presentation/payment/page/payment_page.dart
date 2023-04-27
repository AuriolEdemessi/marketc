import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key, required this.idTransaction})
      : super(key: key);

  final String idTransaction;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    context.read<PaymentCubit>().getTransactionDetails(idTransaction: widget.idTransaction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state){
          if(state.status.isSubmissionInProgress){


          }else if(state.status.isSubmissionFailure){

          }else if(state.status.isSubmissionSuccess){

          }

        },
        builder: (context, state){
          if(state.status.isSubmissionSuccess){
          return paymentWidget(transactionStatus:state.transactionStatus!, context: context);
          }else{
            return Center(child: AppLoadingIndicator(),);
          }
        },
      ),
    );
  }
}

Widget paymentWidget({ required transactionStatus, required BuildContext context}){
  double screenHeight = 400;
   switch(transactionStatus){
   case "pending":
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
             height: 170,
             padding: EdgeInsets.all(35),
             decoration: BoxDecoration(
               //color: AppColors.primary,
               //shape: BoxShape.circle,
             ),
             child: SvgPicture.asset("assets/icons/pending_payment.svg"),
           ),
           SizedBox(height: screenHeight * 0.1),
           Text(
               "Oups!",
               style: kHeading2.copyWith(fontSize: 36, color: AppColors.primary)
           ),
           SizedBox(height: screenHeight * 0.01),
           Text(
             "Paiement non effectué",
             style: TextStyle(
               color: Colors.black87,
               fontWeight: FontWeight.w400,
               fontSize: 17,
             ),
           ),
           SizedBox(height: screenHeight * 0.05),
           Text(
             "Cliquez ici pour revenir à la page d'accueil.",
             textAlign: TextAlign.center,
             style: TextStyle(
               color: Colors.black54,
               fontWeight: FontWeight.w400,
               fontSize: 14,
             ),
           ),
           SizedBox(height: screenHeight * 0.06),
           Flexible(
             child: ButtonWidget(
                 background: AppColors.primary,
                 textColor: AppColors.white,
                 text: "Home",
                 voidCallback: () {
                   context
                       .read<AppMenuCubit>()
                       .setNavBarItem(AppMenuItem.home);
                   Get.offAll(DashboardScreen());
                 }),
           ),
         ],
       ),
     );
   case "approved":
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
             height: 170,
             padding: EdgeInsets.all(35),
             decoration: BoxDecoration(
               //color: AppColors.primary,
               //shape: BoxShape.circle,
             ),
             child: SvgPicture.asset("assets/icons/check_validate.svg"),
           ),
           SizedBox(height: screenHeight * 0.1),
           Text(
               "Merci!",
               style: kHeading2.copyWith(fontSize: 36, color: AppColors.primary)
           ),
           SizedBox(height: screenHeight * 0.01),
           Text(
             "Paiement effectué avec succès",
             style: TextStyle(
               color: Colors.black87,
               fontWeight: FontWeight.w400,
               fontSize: 17,
             ),
           ),
           SizedBox(height: screenHeight * 0.05),
           Text(
             "Vous serez bientôt redirigé vers la page d'accueil\nou cliquez ici pour revenir à la page d'accueil.",
             textAlign: TextAlign.center,
             style: TextStyle(
               color: Colors.black54,
               fontWeight: FontWeight.w400,
               fontSize: 14,
             ),
           ),
           SizedBox(height: screenHeight * 0.06),
           Flexible(
             child: ButtonWidget(
                 background: AppColors.primary,
                 textColor: AppColors.white,
                 text: "Retour à l'accueil",
                 voidCallback: () {
                   context
                       .read<AppMenuCubit>()
                       .setNavBarItem(AppMenuItem.home);
                   Get.offAll(DashboardScreen());
                 }),
           ),
         ],
       ),
     );
   case "canceled":
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
             height: 170,
             padding: EdgeInsets.all(35),
             decoration: BoxDecoration(
               //color: AppColors.primary,
               //shape: BoxShape.circle,
             ),
             child: Image.asset("assets/images/cross.png"),
           ),
           SizedBox(height: screenHeight * 0.1),
           Text(
               "Oups!",
               style: kHeading2.copyWith(fontSize: 36, color: AppColors.primary)
           ),
           SizedBox(height: screenHeight * 0.01),
           Text(
             "Paiement annulé",
             style: TextStyle(
               color: Colors.black87,
               fontWeight: FontWeight.w400,
               fontSize: 17,
             ),
           ),
           SizedBox(height: screenHeight * 0.05),
           Text(
             "Cliquez ici pour revenir à la page d'accueil.",
             textAlign: TextAlign.center,
             style: TextStyle(
               color: Colors.black54,
               fontWeight: FontWeight.w400,
               fontSize: 14,
             ),
           ),
           SizedBox(height: screenHeight * 0.06),
           Flexible(
             child: ButtonWidget(
                 background: AppColors.primary,
                 textColor: AppColors.white,
                 text: "Retour à l'accueil",
                 voidCallback: () {
                   context
                       .read<AppMenuCubit>()
                       .setNavBarItem(AppMenuItem.home);
                   Get.offAll(DashboardScreen());
                 }),
           ),
         ],
       ),
     );
   case "refunded":
     return Text("refunded");
   default :
     return Text("");
 }
}
