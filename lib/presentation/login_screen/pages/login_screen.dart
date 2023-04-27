import 'dart:io';

import 'package:marketscc/main.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  late bool isAndroid;

  final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
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

  Color getColor(Set<MaterialState> states) {
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Scaffold(
      key: scaffoldMessengerKey,
        backgroundColor: AppColors.background,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              loadingOverlay.hide();
              context.read<ProfilCubit>().fetchUser();
              Get.offAllNamed(RoutePaths.dashboardScreen);
            } else if (state.status == FormzStatus.submissionInProgress) {
              return loadingOverlay.show(context);
            } else if (state.status == FormzStatus.submissionFailure){
              loadingOverlay.hide();
              String message="";
              state.message?.errors?.forEach((element) {
                message += "$element\n";
              });
              buildWhitePopUpMessage(message: message.isEmpty? state.message!.release!:message);
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
                      const _TextFieldsInputField(),
                      const SpaceHeight(14),
                      const _PasswordInputField(),
                      const SpaceHeight(20),
                      Padding(
                        padding: EdgeInsets.only(left: 29.w, right: 31.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Row(
                            children: [
                              Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                    child: Container(
                                      height: 24,
                                      width: 24,
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
                                  )),
                              const SpaceWidth(8),
                              Text(
                                "Rappelez-vous de moi",
                                style: kSubtitle2.copyWith(
                                    color: AppColors.primary),
                              ),
                              const Spacer(),
                              InkWell(
                                child: Text(
                                  "Mot de passe oublié?",
                                  style: kSubtitle2.copyWith(
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () =>Get.toNamed(RoutePaths.passForgotScreen),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SpaceHeight(40),
                      _LoginButton(
                        isAndroid: isAndroid,
                        deviceData: _deviceData,
                      ),
                      const SpaceHeight(20),
                      Text.rich(
                        TextSpan(
                          style: kSubtitle1,
                          children: [
                            const TextSpan(
                              text: 'Vous n\'avez pas de compte ? ',
                            ),
                            TextSpan(
                              text: 'Inscrivez-vous ici',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.offAllNamed(RoutePaths.signupScreen),
                              style: kSubtitle1.copyWith(color: AppColors.primary, decoration: TextDecoration.underline,),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

class _TextFieldsInputField extends StatelessWidget {
  const _TextFieldsInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.textFields != current.textFields,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 29.w, right: 29.w),
          child: InputTextField(
            label: "Pseudo ou Email",
            hintText: 'Pseudo ou Email',
            keyboardType: TextInputType.text,
            error: state.textFields.invalid ? 'Champs requis' : null,
            onChanged: (value) => context.read<LoginCubit>().textFieldsChanged(value),
          ),
        );
      },
    );
  }
}


class _PasswordInputField extends StatefulWidget {
  const _PasswordInputField({
    Key? key,
  }) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<_PasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 29.w, right: 29.w),
          child: InputTextField(
            label: "Mot de passe",
            hintText: '',
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
            error: state.password.invalid ? 'Invalid password' : null,
            keyboardType: TextInputType.text,
            onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final Map<String, dynamic> deviceData;
  final bool isAndroid;

  _LoginButton({required this.isAndroid, required this.deviceData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 29, right: 29),
          child: ButtonWidget(
            background: state.status.isValidated ? AppColors.primary : AppColors.grey,
            textColor: AppColors.white,
            text: "Se connecter",
            voidCallback: () => state.status.isValidated
                ? context.read<LoginCubit>().logInWithCredentials(
                    isAndroid: isAndroid, deviceData: deviceData)
                : null,
          ),
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
