import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../../../main.dart';

class PassForgotScreen extends StatefulWidget {
  const PassForgotScreen({Key? key}) : super(key: key);

  @override
  State<PassForgotScreen> createState() => _PassForgotScreenState();
}

class _PassForgotScreenState extends State<PassForgotScreen> {
  final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Scaffold(
      key: scaffoldMessengerKey,
        backgroundColor: AppColors.background,
        body: BlocListener<PassForgotCubit, PassForgotState>(
          listener: (context, state) async{
            if (state.status == FormzStatus.submissionSuccess) {
             // await 1.delay();
              //context.read<PassForgotCubit>().init();
              loadingOverlay.hide();
              showToast(scaffoldMessengerKey, state.dataResponse?.message);
              Get.offAndToNamed(RoutePaths.codeOtpScreen, arguments: state.dataResponse!.email as String);
            } else if (state.status == FormzStatus.submissionInProgress) {
              loadingOverlay.show(context);
            } else if (state.status == FormzStatus.submissionFailure) {
              loadingOverlay.hide();
              buildWhitePopUpMessage(message: '${state.message?.release}');
            }
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(AppAssets.icBg),
              ),
              Positioned(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SpaceHeight(73),
                      const Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AppAssets.imgLogo512,
                          width: 114,
                          height: 114,
                        ),
                      ),
                      const SpaceHeight(64),
                      Text("Un code de verification vous sera envoyé"),
                      const SpaceHeight(20),
                      const _EmailInputField(),
                      const SpaceHeight(40),
                      _LoginButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    ));
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassForgotCubit, PassForgotState>(
      buildWhen: (previous, current) =>
      previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 29.w, right: 29.w),
          child: InputTextField(
            label: "Email",
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            error: state.email!.invalid ? 'Adresse email invalide' : null,
            onChanged: (value) => context.read<PassForgotCubit>().emailChanged(value),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassForgotCubit, PassForgotState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
            background: state.status.isValidated ? AppColors.primary : AppColors.grey,
            textColor: AppColors.white,
            text: "Envoyer",
            voidCallback: () => state.status.isValidated
                ? context.read<PassForgotCubit>().sendRequestChangeCode()
                : null,
          ),
        );
      },
    );
  }
}
