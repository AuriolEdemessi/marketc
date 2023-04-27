import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../../../main.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({
    Key? key,
  }) : super(key: key);

  @override
  FeedBackScreenState createState() => FeedBackScreenState();
}

class FeedBackScreenState extends State<FeedBackScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<FeebakCubit, FeedbakState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
             // loadingOverlay.hide();
              //context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.home);
            } else if (state.status == FormzStatus.submissionInProgress) {
             // return loadingOverlay.show(context);
            } else if (state.status == FormzStatus.submissionFailure) {
             // loadingOverlay.hide();
              String message ="";

              state.message?.errors?.forEach((element) {
                message+=element;
              });

              buildWhitePopUpMessage(message: '$message');
            }
          },
          builder: (context, state){
            if(state.status.isSubmissionSuccess){
              return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SpaceHeight(30),
                      Center(child: Image.asset("assets/images/validate_icon.jpg", height: 200, width: 200,),),
                      SpaceHeight(100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text("${state.testimonyResponse?.message}.", textAlign: TextAlign.center, style: kHeading4,),
                      ),
                      SpaceHeight(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: "Votre code de témoignage est : ", style: kHeading4),
                          TextSpan(text: "${state.testimonyResponse?.data?.code}", style: kHeading4.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                        ])),
                      ),
                      SpaceHeight(50),
                      ButtonWidget(
                          width: 200,
                          height: 40,
                          background: AppColors.primary,
                          textColor: AppColors.white,
                          text: "Home",
                          voidCallback: () {
                            context.read<FeebakCubit>().initState();
                            context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.home);
                            Get.offAll(DashboardScreen());
                          }),
                      SpaceHeight(kToolbarHeight+50)
                    ],
                  ),

              );
            }else{
              return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Text(
                          "Votre témoignage apparaîtra sur la première page une fois approuvé",
                          style: kHeading4,
                        ),
                      ),
                      SpaceHeight(30),
                      BlocBuilder<FeebakCubit, FeedbakState>(
                        buildWhen: (previous, current) =>
                        previous.temoignage != current.temoignage,
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 29, right: 29),
                            child: InputTextField(
                              label: "Votre témoignage",
                              maxline: 10,
                              minline: 10,
                              keyboardType: TextInputType.multiline,
                              error:
                              state.temoignage.invalid ? 'Message invalide' : null,
                              onChanged: (value) =>
                                  context.read<FeebakCubit>().temoignageChanged(value),
                            ),
                          );
                        },
                      ),
                      SpaceHeight(20),
                      sendTemoignageButton(),
                    ],
                  ));
            }
          },
        ));
  }
}

class sendTemoignageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeebakCubit, FeedbakState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress? AppLoadingIndicator(): Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
            background:
                state.status.isValidated ? AppColors.primary : AppColors.grey,
            textColor: AppColors.white,
            text: "Publier",
            voidCallback: () => state.status.isValidated
                ? context.read<FeebakCubit>().sendTemoignage()
                : null,
          ),
        );
      },
    );
  }
}
