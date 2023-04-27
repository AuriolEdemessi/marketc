import 'package:marketscc/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../export.dart';
import '../widgets/verification_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          onRefresh: () => refresh(),
          strokeWidth: 2,
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: BlocBuilder<ProfilCubit, ProfilState>(

               /* listener: (context, state) {
                  if (state.kycVerifyStatus.isSubmissionFailure || state.status.isSubmissionFailure || state.revendeurVerifyStatus.isSubmissionFailure) {
                    loadingOverlay.hide();
                  } else if (state.kycVerifyStatus.isSubmissionSuccess || state.status.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess) {
                    loadingOverlay.hide();
                    if(state.kycVerifyStatus.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess){

                      //buildWhitePopUpMessage(message: "Demande de vérification de compte envoyée avec succès.");

                    }
                  } else if (state.kycVerifyStatus.isSubmissionInProgress || state.status.isSubmissionInProgress || state.revendeurVerifyStatus.isSubmissionInProgress) {
                    loadingOverlay.show(context);
                  }
                },*/
                builder: (context, state) {
                  if (state.kycVerifyStatus.isSubmissionFailure || state.status.isSubmissionFailure) {
                    return CustomError(errorMessage: state.message!);
                  } else if (state.kycVerifyStatus.isSubmissionSuccess || state.status.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess) {
                    if((state.kycVerifyStatus.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess) & !isFirst){
                      context.read<ProfilCubit>().fetchUser();
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        setState((){
                          isFirst = true;
                        });
                      });
                    }
                    return statusWidget(state.userResponse?.user?.verified);
                  }else {
                    return Center(child: AppLoadingIndicator());
                  }
                },
              ),),
             /* child: BlocConsumer<ProfilCubit, ProfilState>(
              listener: (context, state) {
                if (state.kycVerifyStatus.isSubmissionFailure || state.status.isSubmissionFailure || state.revendeurVerifyStatus.isSubmissionFailure) {
                  loadingOverlay.hide();
                } else if (state.kycVerifyStatus.isSubmissionSuccess || state.status.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess) {
                  loadingOverlay.hide();
                  if(state.kycVerifyStatus.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess){

                     //buildWhitePopUpMessage(message: "Demande de vérification de compte envoyée avec succès.");

                  }
                } else if (state.kycVerifyStatus.isSubmissionInProgress || state.status.isSubmissionInProgress || state.revendeurVerifyStatus.isSubmissionInProgress) {
                  loadingOverlay.show(context);
                }
              },
              builder: (context, state) {
                if (state.kycVerifyStatus.isSubmissionFailure || state.status.isSubmissionFailure) {
                  return CustomError(errorMessage: state.message!);
                } else if (state.kycVerifyStatus.isSubmissionSuccess || state.status.isSubmissionSuccess || state.revendeurVerifyStatus.isSubmissionSuccess) {
                  return statusWidget(state.userResponse?.user?.verified);
                }else {
                  return Center(child: AppLoadingIndicator());
                }
              },
            ),),*/
          )
        ),
      ),
    ));
  }

  Future<void> refresh() async {
    //context.read<HomeCubit>().fetchAccount();
    context.read<ProfilCubit>().fetchUser();
  }
}

Widget statusWidget(int? statut) {
  switch (statut) {
    case 1:
      return KycInProgress(
        texte: "Vérification client en attente",
        description: "Nous sommes toujours en train de traiter votre vérification d'identité client. Une fois que notre équipe ait vérifié votre identité, vous serez averti par e-mail. Vous pouvez également vérifier l'état de conformité de votre vérification à partir de cette page.",
      );
    case 2:
    case 6:
      return CustomCompteActive();
    case 3:
      return KycInProgress(
        texte: "Vérification revendeur en attente",
        description: "Nous sommes toujours en train de traiter votre vérification d'identité revendeur. Une fois que notre équipe ait vérifié votre identité, vous serez averti par e-mail. Vous pouvez également vérifier l'état de conformité de votre vérification à partir de cette page.",
      );
    case 4:
      return MarchandActive();
    case 5:
      return VerificationWidget();
    default:
      return VerificationWidget();
  }
}
