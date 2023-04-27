import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketscc/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../export.dart';

enum UploadState { NOTHING, PROGRESSE, FINISH }

class DrawerMenu extends StatefulWidget {
  final AnimationController animationController;

  const DrawerMenu({Key? key, required this.animationController})
      : super(key: key);

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  final GlobalKey<ScaffoldState> scaffoldMessengerKey =
      GlobalKey<ScaffoldState>();

  File? imageFile;

  late UploadState uploadState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: scaffoldMessengerKey,
      child: ListView(
        children: [
          BlocBuilder<ProfilCubit, ProfilState>(builder: (context, state) {
            if (state.status.isSubmissionSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2, color: AppColors.primary),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                            ),
                            child: imageFile != null
                                ? BlocConsumer<ProfilCubit, ProfilState>(
                                    listener: (context, state) {
                                    if (state.uploaImage.isSubmissionSuccess) {
                                      buildWhitePopUpMessage(
                                          message:
                                              "Votre profil a été mis à jour avec succés.");
                                    }
                                  }, builder: (context, state) {
                                    if (state
                                        .uploaImage.isSubmissionInProgress) {
                                      return Center(
                                          child: AppLoadingIndicator());
                                    } else if (state
                                        .uploaImage.isSubmissionSuccess) {
                                      return ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              state.userResponse!.user!.image!,
                                          placeholder: (context, url) => Center(
                                              child: AppLoadingIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                      );
                                    } else if (state
                                        .uploaImage.isSubmissionFailure) {
                                      return Text("");
                                    } else {
                                      return Text("");
                                    }
                                  })
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: state
                                              .userResponse?.user?.image ??
                                          "https://www.pngitem.com/pimgs/b/146-1468479_profile-icon-png.png",
                                      placeholder: (context, url) =>
                                          Center(child: AppLoadingIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                  )

                            /*ClipOval(
                                child:Image.file(imageFile!, fit: BoxFit.cover,)): state.userResponse!.user?.image ==null?Image.asset('assets/images/user.png', fit: BoxFit.cover,):
                              ClipOval(
                                child:CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: state.userResponse!.user!.image!,
                                  placeholder: (context, url) => Center(child: AppLoadingIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  width: 80.0,
                                  height: 80.0,
                                ),)*/
                            ),
                        Positioned(
                            top: 5,
                            right: -5,
                            child: InkWell(
                                onTap: () {
                                  buildBottomSheetPickup(context,
                                      onPickFile: (file) async {
                                    if (file != null) {
                                      setState(() {
                                        imageFile = file;
                                      });
                                      dio.FormData formData =
                                          dio.FormData.fromMap({
                                        "image":
                                            await dio.MultipartFile.fromFile(
                                                imageFile!.path),
                                      });
                                      context
                                          .read<ProfilCubit>()
                                          .uploadImageProfile(data: formData);
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                )))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        '${state.userResponse!.user?.lname} ${state.userResponse!.user?.fname}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status.isSubmissionFailure) {
              return CustomError(errorMessage: state.message!);
            } else {
              return Center(child: AppLoadingIndicator());
            }
          }),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppColors.grey.withOpacity(0.6),
          ),
          const SpaceHeight(20),
          BlocBuilder<AppMenuCubit, AppMenuState>(builder: (context, state) {
            return Column(
              children: [
                InkWell(
                  onTap: () => setBottomBarIndex(AppMenuItem.profil),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.profil
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgProfil,
                          color: state.appMenuItem == AppMenuItem.profil
                              ? AppColors.white
                              : AppColors.primary,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'Profil',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.profil
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () => setBottomBarIndex(AppMenuItem.verification),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.verification
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgKyc,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'KYC',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.verification
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () {
                    setBottomBarIndex(AppMenuItem.help);
                    Get.to(() => HelpScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.help
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          //image: AppAssets.imgAide,
                          image: AppAssets.imgAide,
                          color: state.appMenuItem == AppMenuItem.help
                              ? AppColors.white
                              : AppColors.primary,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'Help',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.help
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () => setBottomBarIndex(AppMenuItem.feedback),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.feedback
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgFeedback,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'FeedBack',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.feedback
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () => setBottomBarIndex(AppMenuItem.faq),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.faq
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgFaq,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'FAQ',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.faq
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () => setBottomBarIndex(AppMenuItem.share),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.share
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgShare,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'Invite Friend',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.share
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () {
                    if (Platform.isAndroid) {
                      _launchUrl(
                          "https://play.google.com/store/apps/details?id=com.marketscc.app");
                    } else if (Platform.isIOS) {
                      _launchUrl(
                          "https://apps.apple.com/app/cryptocurrency-markets/id6444154765");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.rate
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgRate,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'Rate the app',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.rate
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SpaceHeight(8),
                InkWell(
                  onTap: () {
                    setBottomBarIndex(AppMenuItem.about);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    alignment: Alignment.center,
                    height: 46,
                    decoration: state.appMenuItem == AppMenuItem.about
                        ? BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border:
                                Border.all(width: 1, color: AppColors.white),
                            color: AppColors.primary,
                          )
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AppAssets.imgAbout,
                          width: 24,
                          height: 24,
                        ),
                        const SpaceWidth(10),
                        Text(
                          'About',
                          style: kHeading4.copyWith(
                            color: state.appMenuItem == AppMenuItem.about
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          const SpaceHeight(20),
          Divider(
            height: 1,
            color: AppColors.grey.withOpacity(0.6),
          ),
          BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) async {
            if (state.status == FormzStatus.submissionSuccess) {
              await 1.delay();
              context.read<LoginCubit>().init();
              loadingOverlay.hide();
              context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.home);
              Get.offAllNamed(RoutePaths.loginScreen);
            } else if (state.status == FormzStatus.submissionFailure) {
              loadingOverlay.hide();
              ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!)
                  .showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      content: NotificationWidget()));
            }
          }, builder: (context, state) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    'Me déconnecter',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.darkText,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: const Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () {
                    loadingOverlay.show(context);
                    context.read<ProfilCubit>().setUserData(null);
                    context.read<LoginCubit>().logout();
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  setBottomBarIndex(menuItem) {
    context.read<AppMenuCubit>().setNavBarItem(menuItem);
    widget.animationController.reset();
    Navigator.pop(context);
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
