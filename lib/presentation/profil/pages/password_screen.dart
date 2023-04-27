import 'package:flutter/material.dart';

import '../../../export.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      const SpaceHeight(10),
      NowPasswordInputField(),
      NewPasswordInputField(),
      ConfirmedPasswordInputField(),

    ],),);
  }
}


class NowPasswordInputField extends StatefulWidget {
  const NowPasswordInputField({Key? key}) : super(key: key);
  @override
  NowPasswordInputFieldState createState() => NowPasswordInputFieldState();
}
class NowPasswordInputFieldState extends State<NowPasswordInputField> {

  bool  obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordChangedCubit, PasswordChangedState>(
      buildWhen: (previous, current) => previous.nowPassword != current.nowPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
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
            error: state.nowPassword.invalid ? 'Champs requis' : null,
            keyboardType: TextInputType.text,
            onChanged: (value) => context.read<SignupCubit>().passwordChanged(value),
          ),
        );
      },
    );
  }
}

class NewPasswordInputField extends StatefulWidget {
  const NewPasswordInputField({Key? key}) : super(key: key);
  @override
  NewPasswordInputFieldState createState() => NewPasswordInputFieldState();
}
class NewPasswordInputFieldState extends State<NewPasswordInputField> {
  bool  obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordChangedCubit, PasswordChangedState>(
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
            onChanged: (value) => context.read<PasswordChangedCubit>().newPasswordChanged(value),
          ),
        );
      },
    );
  }
}

class ConfirmedPasswordInputField extends StatefulWidget {
  const ConfirmedPasswordInputField({Key? key}) : super(key: key);
  @override
  ConfirmedPasswordInputFieldState createState() => ConfirmedPasswordInputFieldState();
}
class ConfirmedPasswordInputFieldState extends State<ConfirmedPasswordInputField> {

  bool  obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordChangedCubit, PasswordChangedState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InputTextField(
            label: "Mot de passe actuelle",
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
            onChanged: (value) => context.read<PasswordChangedCubit>().confirmedPasswordChanged(value),
          ),
        );
      },
    );
  }
}


class UpdatePassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordChangedCubit, PasswordChangedState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
            background:
            state.status.isValidated ? AppColors.primary : AppColors.grey,
            textColor: AppColors.white,
            text: "Mettre a jour",
            voidCallback: () => state.status.isValidated
                ? context.read<PasswordChangedCubit>().updatePassword()
                : null,
          ),
        );
      },
    );
  }
}