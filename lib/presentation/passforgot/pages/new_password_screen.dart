import 'package:marketscc/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

class NewPasswordResetScreen extends StatefulWidget {
  final String token;

  const NewPasswordResetScreen({Key? key, required this.token}) : super(key: key);


  @override
  State<NewPasswordResetScreen> createState() => NewPasswordResetScreenState();
}

class NewPasswordResetScreenState extends State<NewPasswordResetScreen> {

  final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Scaffold(
      key: scaffoldMessengerKey,
      backgroundColor: AppColors.background,
      body: BlocListener<NewPasswordCubit, NewPasswordState>(
          listener: (context, state){
            if(state.status.isSubmissionInProgress){
              loadingOverlay.show(context);
            }else if(state.status.isSubmissionFailure){
              loadingOverlay.hide();
              buildWhitePopUpMessage(message: '${state.message?.release}');
            }else if(state.status.isSubmissionSuccess){
              loadingOverlay.hide();
              showToast(scaffoldMessengerKey, state.dataresponse?.message);
              Get.offAllNamed(RoutePaths.loginScreen);
            }
          },
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(AppAssets.icBg),
            ),
            Positioned(
                child:SingleChildScrollView( child:Column(children: [
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
                  const SpaceHeight(10),
                  NewPasswordResetInputField(),
                  const SpaceHeight(10),
                  ConfirmedPasswordResetInputField(),
                  const SpaceHeight(20),
                  ResetPassword(widget.token),
                ],))),
          ],)
      ),));
  }
}


class NewPasswordResetInputField extends StatefulWidget {
  const NewPasswordResetInputField({Key? key}) : super(key: key);
  @override
  NewPasswordResetInputFieldState createState() => NewPasswordResetInputFieldState();
}
class NewPasswordResetInputFieldState extends State<NewPasswordResetInputField> {
  bool  obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordCubit, NewPasswordState>(
      buildWhen: (previous, current) => previous.newPassword != current.newPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InputTextField(
            label: "Nouveau mot de passe",
            hintText: '● ● ● ● ● ● ●',
            isSuffixIcon: true,
            obscureText: obscureText,
            suffixWidget: IconButton(
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            error: state.newPassword.invalid ? 'Champs requis' : null,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => context.read<NewPasswordCubit>().newPasswordChanged(value),
          ),
        );
      },
    );
  }
}


class ConfirmedPasswordResetInputField extends StatefulWidget {
  const ConfirmedPasswordResetInputField({Key? key}) : super(key: key);
  @override
  ConfirmedPasswordResetInputFieldState createState() => ConfirmedPasswordResetInputFieldState();
}
class ConfirmedPasswordResetInputFieldState extends State<ConfirmedPasswordResetInputField> {

  bool  obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordCubit, NewPasswordState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InputTextField(
            label: "Confirmer mot de passe",
            hintText: '● ● ● ● ● ● ●',
            isSuffixIcon: true,
            obscureText: obscureText,
            suffixWidget: IconButton(
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            error: state.confirmedPassword.invalid ? 'mismatch' : null,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => context.read<NewPasswordCubit>().confirmedPasswordChanged(value),
          ),
        );
      },
    );
  }
}



class ResetPassword extends StatelessWidget {
final String token;
 ResetPassword(this.token);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordCubit, NewPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
            background:
            state.status.isValidated ? AppColors.primary : AppColors.grey,
            textColor: AppColors.white,
            text: "Changer",
            voidCallback: () => state.status.isValidated
                ? context.read<NewPasswordCubit>().resetPassword(token)
                : null,
          ),
        );
      },
    );

  }
}

