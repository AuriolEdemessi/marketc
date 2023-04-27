import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../../../main.dart';

class CodeOtpScreen extends StatefulWidget {
  final String email;
  const CodeOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<CodeOtpScreen> createState() => _CodeOtpScreenState();
}

class _CodeOtpScreenState extends State<CodeOtpScreen> {
  bool enableButton = false;
  late String codeOtp;

  final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return MainLayout(

        child: Scaffold(
            key: scaffoldMessengerKey,
        backgroundColor: AppColors.background,
        body: BlocListener<OtpCubit, OtpState>(
          listener: (context, state) async{
            if (state.status.isSubmissionSuccess) {
              loadingOverlay.hide();
              Get.offNamed(RoutePaths.newPasswordResetSreen, arguments: state.data?.token);
            } else if (state.status.isSubmissionInProgress) {
              loadingOverlay.show(context);
            } else if (state.status.isSubmissionFailure) {
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
                      _OtpTextFieldsInput(),
                      const SpaceHeight(40),
                      BlocBuilder<OtpCubit, OtpState>(
                        buildWhen: (previous, current) => previous.status != current.status,
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 29, right: 29),
                            child: ButtonWidget(
                              background: state.status.isValidated ? AppColors.primary : AppColors.grey,
                              textColor: AppColors.white,
                              text: "Envoyer",
                              voidCallback: () => state.status.isValidated ? context.read<OtpCubit>().forgotCheck(widget.email)
                                  : null,
                            ),
                          );
                        },
                      )
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


class _OtpTextFieldsInput extends StatelessWidget {
  const _OtpTextFieldsInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen: (previous, current) => previous.otpTextFields != current.otpTextFields,
      builder: (context, state) {
    return Padding(
      padding: EdgeInsets.only(left: 29.w, right: 29.w),
      child: InputTextField(
        label: "Code otp",
        hintText: 'Code otp',
        keyboardType: TextInputType.text,
        error: state.otpTextFields.invalid ? 'Champs requis' : null,
        onChanged: (value) => context.read<OtpCubit>().otpTextFieldsChanged(value),
      ),
    );});
}
}


