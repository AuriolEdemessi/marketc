import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketscc/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../export.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  late bool isAndroid;

  TextEditingController controllerReferBy = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldMessengerKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Color getColor(Set<MaterialState> states) {
    return AppColors.primary;
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        isAndroid = true;
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        isAndroid = false;
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Scaffold(
      key: scaffoldMessengerKey,
      backgroundColor: AppColors.background,
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            loadingOverlay.hide();
            Get.offAllNamed(RoutePaths.dashboardScreen);
          } else if (state.status == FormzStatus.submissionInProgress) {
            return loadingOverlay.show(context);
          } else if (state.status == FormzStatus.submissionFailure) {
            loadingOverlay.hide();
            String message = "";
            state.message?.errors?.forEach((element) {
              message += "$element\n";
            });
            buildWhitePopUpMessage(message: message);
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
                  Text(
                    "CRYPTOCURRENCY MARKETS",
                  ),
                  const SpaceHeight(34),
                  const _LastNameInputField(),
                  const SpaceHeight(14),
                  const _FirstNameInputField(),
                  const SpaceHeight(14),
                  const _PseudoInputField(),
                  const SpaceHeight(14),
                  const _EmailInputField(),
                  const SpaceHeight(14),
                  PhoneNumberdInput(
                    label: "Numéro de télephone",
                    hintText: '97979797',
                  ),
                  const SpaceHeight(14),
                  const PasswordInputField(),
                  const SpaceHeight(14),
                  Padding(
                    padding: const EdgeInsets.only(left: 29, right: 29),
                    child: InputTextField(
                      label: "Code d'affiliation",
                      hintText: 'xxxxx',
                      keyboardType: TextInputType.text,
                      controller: controllerReferBy,
                      isSuffixIcon: true,
                      suffixWidget: IconButton(
                        icon: const Icon(Icons.paste),
                        onPressed: () {
                          FlutterClipboard.paste().then((value) {
                            controllerReferBy.text = value;
                          });
                        },
                      ),
                      onChanged: (value) {
                        // controllerReferBy.text = value;
                      },
                    ),
                  ),
                  const SpaceHeight(30),
                  Padding(
                    padding: const EdgeInsets.only(left: 29, right: 29),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              //color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(RadiusSizes.r5)),
                            ),
                            child: isChecked
                                ? const Icon(
                                    Icons.check_box,
                                    size: 24.0,
                                    color: AppColors.primary,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    size: 24.0,
                                    color: AppColors.primary,
                                  ),
                          ),
                        ),
                        //SpaceWidth(8),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: kSubtitle1,
                              children: [
                                TextSpan(
                                    text:
                                        'Je suis d\'accord avec la Politique de confidentialité, ',
                                    style: kSubtitle2.copyWith()),
                                TextSpan(
                                  text: 'les termes  & conditions ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchInBrowser();
                                    },
                                  style: kSubtitle2.copyWith(
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: 'de Marketscc',
                                  style: kSubtitle2.copyWith(),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SpaceHeight(40),
                  _SignupButton(
                    isAndroid: isAndroid,
                    deviceData: _deviceData,
                    valueReferBy: controllerReferBy.text,
                    isChecked: isChecked,
                  ),
                  const SpaceHeight(20),
                  Text.rich(
                    TextSpan(
                      style: kSubtitle1,
                      children: [
                        const TextSpan(
                          text: 'Vous avez dejà un compte ? ',
                        ),
                        TextSpan(
                          text: 'Connectez-vous ici',
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Get.offAllNamed(RoutePaths.loginScreen),
                          style: kSubtitle1.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SpaceHeight(40),
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }
}

class _LastNameInputField extends StatelessWidget {
  const _LastNameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: InputTextField(
            label: "Nom",
            hintText: 'Doe',
            keyboardType: TextInputType.text,
            error: state.lastname.invalid ? 'Invalid adresse email' : null,
            onChanged: (value) =>
                context.read<SignupCubit>().lastNameChanged(value),
          ),
        );
      },
    );
  }
}

class _FirstNameInputField extends StatelessWidget {
  const _FirstNameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: InputTextField(
            label: "Prénom",
            hintText: 'John',
            keyboardType: TextInputType.text,
            error: state.firstname.invalid ? 'Champs requis' : null,
            onChanged: (value) =>
                context.read<SignupCubit>().firstNameChanged(value),
          ),
        );
      },
    );
  }
}

class _PseudoInputField extends StatelessWidget {
  const _PseudoInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.pseudo != current.pseudo,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: InputTextField(
            label: "Pseudo",
            hintText: 'johndohn',
            keyboardType: TextInputType.text,
            error: state.pseudo.invalid
                ? ' Le pseudo doit comporter au moins 5 caractères.'
                : null,
            onChanged: (value) =>
                context.read<SignupCubit>().pseudoChanged(value),
          ),
        );
      },
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: InputTextField(
            label: "Email",
            hintText: 'johndoe@gmail.com',
            keyboardType: TextInputType.emailAddress,
            error: state.email.invalid ? 'Invalid adresse email' : null,
            onChanged: (value) =>
                context.read<SignupCubit>().emailChanged(value),
          ),
        );
      },
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({Key? key}) : super(key: key);

  @override
  PasswordInputFieldState createState() => PasswordInputFieldState();
}

class PasswordInputFieldState extends State<PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: InputTextField(
            label: "Mot de passe",
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
            error: state.password.invalid ? 'Champs requis' : null,
            keyboardType: TextInputType.text,
            onChanged: (value) =>
                context.read<SignupCubit>().passwordChanged(value),
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  final Map<String, dynamic> deviceData;
  final bool isAndroid;
  final String? valueReferBy;
  final bool isChecked;

  _SignupButton(
      {required this.isAndroid,
      required this.deviceData,
      this.valueReferBy,
      required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
              background:
                  state.status.isValidated ? AppColors.primary : AppColors.grey,
              textColor: AppColors.white,
              text: "S'inscrire",
              voidCallback: () {
                if (isChecked) {
                  state.status.isValidated
                      ? context.read<SignupCubit>().signupUser(
                          isAndroid: isAndroid,
                          deviceData: deviceData,
                          referBy: valueReferBy)
                      : null;
                } else {
                  buildWhitePopUpMessage(message: "Vous devez acceptez les terms et condition de Marketscc");
                }
              }),
        );
      },
    );
  }
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

Future<void> _launchInBrowser() async {
  final Uri toLaunch =
      Uri(scheme: 'https', host: 'www.marketscc.com', path: 'sandbox/privacy');
  if (!await launchUrl(
    toLaunch,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $toLaunch';
  }
}
