import 'package:marketscc/presentation/annonce/pages/list_devise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:math' as math;
import '../../../export.dart';
import '../../message/message.dart';
import '../../message/single_message.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

enum ExpansionStatus { open, close, idle }

class DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {

  late AnimationController animationController;

  bool? isshow;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
    putDeviceId();
    Future.microtask(() {
      context.read<AnnonceCubit>().fetchAnnonceList();
      context.read<HomeCubit>().fetchTransaction();
      context.read<HomeCubit>().fetchBrandImage();
      context.read<ProfilCubit>().fetchUser();
      context.read<AnnonceCubit>().fetchExchangeListe();
      context.read<NotificationCubit>().unreadNotif();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void putDeviceId() async{
    final status = await OneSignal.shared.getDeviceState();
    await hive.saveOsUserID(status?.userId);
    context.read<ProfilCubit>().putDeviceId(deviceId: await hive.getOsUserID(), version: "10.0");
  }

  //late AnimationController animationControllerButton;
  static const List<IconData> icons = [ Icons.sms, Icons.mail,];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void onPressed(BuildContext context) async {
    await showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) => Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Delete'),
              onTap: () => Navigator.of(context).pop('delete'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Cancel'),
              onTap: () => Navigator.of(context).pop('cancel'),
            )
          ],
        ),
      ),
    );
  }

  void onPressedHandler() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else if(animationController.isCompleted){
      animationController.reverse();
    }
  }

  double diameter= 10;



Future<bool?> _showDialog(context, animationController) {
  return showDialog(
    context: context,
   // barrierDismissible: true,
    barrierColor: Colors.grey.withOpacity(0.1),
    builder: (_) =>Dialog(backgroundColor: Colors.transparent, alignment: Alignment.bottomCenter, child: Container(alignment: Alignment.bottomCenter, height: 150, child: FunkyOverlay(animationController: animationController,)),),
  );
}


  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Container(
      color: AppColors.background,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonView(
          addClick: () async{
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (builder) {
                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      padding: const EdgeInsets.only(
                        bottom: 15.0,
                        left: 15.0,
                        right: 15.0,
                        top: 10.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SpaceHeight(50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.listDevise);
                                    Get.back();
                                  },
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AppAssets.imgExchange,
                                        height: 30,
                                       // color: AppColors.primary,
                                      ),
                                      Text("Poster annonce")
                                    ],
                                  )),
                              InkWell(
                                  onTap: () {
                                    context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.mesAnnonces);
                                    Get.back();
                                  },
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AppAssets.imgAnnonce2,
                                        height: 30,
                                       // color: AppColors.primary,
                                      ),
                                      Text("Historiques annonces")
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  });
          },
        ),
        key: _scaffoldKey,
        appBar: CustomAppBar(),
        drawer: DrawerMenu(animationController: animationController,),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Stack(
          clipBehavior:Clip.none,
          alignment: Alignment.topCenter,
          children: [
            BottomMenu(animationController: animationController,),
          ],
        ),

        body: Column(
          children: <Widget>[
            Expanded(
              child: BlocBuilder<AppMenuCubit, AppMenuState>(builder: (context, state) {
                if (state.appMenuItem == AppMenuItem.home) {
                  return  HomeScreen(animationController: animationController,);
                } else if (state.appMenuItem == AppMenuItem.listDevise) {
                  return const ListDevisePage();
                }else if (state.appMenuItem == AppMenuItem.mesAnnonces) {
                  return const ListeMesAnnonces();
                } else if (state.appMenuItem == AppMenuItem.purchases) {
                  return const PurchasesTransactionScreen();
                } else if (state.appMenuItem == AppMenuItem.sales) {
                  return const SalesTransactionScreen();
                } else if (state.appMenuItem == AppMenuItem.profil) {
                  return const ProfilScreen();
                } else if (state.appMenuItem == AppMenuItem.annonce) {
                  return const AnnonceScreen();
                } else if (state.appMenuItem == AppMenuItem.about) {
                  return const AboutScreen();
                }else if (state.appMenuItem == AppMenuItem.verification) {
                  return const VerificationScreen();
                }else if (state.appMenuItem == AppMenuItem.faq) {
                  return const FaqScreen();
                }else if (state.appMenuItem == AppMenuItem.feedback) {
                  return const FeedBackScreen();
                }else if (state.appMenuItem == AppMenuItem.share) {
                  return const AffiliationScreen();
                }/*else if (state.appMenuItem == AppMenuItem.help) {
                 // return const SingleMessageScreen();
                  return const HelpScreen();
                }*/
                else if (state.appMenuItem == AppMenuItem.rate) {
                  return Text("");
                }
                return HomeScreen(animationController: animationController,);
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.6875000);
    path_0.cubicTo(0, size.height * 0.3078044, size.width * 0.1026015, 0, size.width * 0.2291667, 0);
    path_0.lineTo(size.width * 0.7708333, 0);
    path_0.cubicTo(size.width * 0.8973979, 0, size.width, size.height * 0.3078044, size.width, size.height * 0.6875000);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.6875000);
    path_0.close();
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.primary.withOpacity(0.56);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class FormCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width,size.height);
    path_0.lineTo(size.width*0.6239316,size.height);
    path_0.cubicTo(size.width*0.6153846,size.height*0.7684211,size.width*0.5505684,size.height*0.6842105,size.width*0.5192308,size.height*0.6710526);
    path_0.lineTo(size.width*0.5192308,0);
    path_0.cubicTo(size.width*0.5341880,0,size.width*0.5760684,size.height*0.01052632,size.width*0.6239316,size.height*0.05263158);
    path_0.cubicTo(size.width*0.6837607,size.height*0.1052632,size.width*0.7464145,size.height*0.1450855,size.width*0.8482906,size.height*0.4078947);
    path_0.cubicTo(size.width*0.9273504,size.height*0.6118421,size.width*0.9843291,size.height*0.8881579,size.width,size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = const Color(0xff1E1F3C).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.4957265,size.height*0.6776316);
    path_1.cubicTo(size.width*0.4170940,size.height*0.6986842,size.width*0.3903132,size.height*0.9013158,size.width*0.3867521,size.height);
    path_1.lineTo(0,size.height);
    path_1.lineTo(size.width*0.01709402,size.height*0.8684211);
    path_1.cubicTo(size.width*0.03988603,size.height*0.7368421,size.width*0.1149573,size.height*0.4236842,size.width*0.2329060,size.height*0.2236842);
    path_1.cubicTo(size.width*0.3508547,size.height*0.02368434,size.width*0.4572650,size.height*-0.004385816,size.width*0.4957265,size.height*0.006579105);
    path_1.lineTo(size.width*0.4957265,size.height*0.6776316);
    path_1.close();

    Paint paint1Fill = Paint()..style=PaintingStyle.fill;
    paint1Fill.color = const Color(0xff1E1F3C).withOpacity(1.0);
    canvas.drawPath(path_1,paint1Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File

class Form0CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.9958333,size.height*0.5657895);
    path_0.cubicTo(size.width*0.7875000,size.height*0.6118421,size.width*0.7291667,size.height*0.8552632,size.width*0.7208333,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width*0.03836208,size.height*0.8678197);
    path_0.cubicTo(size.width*0.08333333,size.height*0.7565789,size.width*0.2341308,size.height*0.4210526,size.width*0.4700792,size.height*0.2201395);
    path_0.cubicTo(size.width*0.7060275,size.height*0.01922539,size.width*0.9188917,size.height*-0.008972921,size.width*0.9958333,size.height*0.002042066);
    path_0.lineTo(size.width*0.9958333,size.height*0.2828947);
    path_0.lineTo(size.width*0.9958333,size.height*0.5657895);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff1E1F3C).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Form1CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width,size.height);
    path_0.lineTo(size.width*0.2680849,size.height);
    path_0.cubicTo(size.width*0.2680849,size.height*0.7368421,size.width*0.08510672,size.height*0.5657895,0,size.height*0.5657895);
    path_0.lineTo(0,0);
    path_0.cubicTo(size.width*0.03150824,0,size.width*0.1069655,size.height*0.01052632,size.width*0.2077916,size.height*0.05263158);
    path_0.cubicTo(size.width*0.3338252,size.height*0.1052632,size.width*0.4658059,size.height*0.1450855,size.width*0.6804160,size.height*0.4078947);
    path_0.cubicTo(size.width*0.8469580,size.height*0.6118421,size.width*0.9669916,size.height*0.8881579,size.width,size.height);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff1E1F3C).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class FunkyOverlay extends StatefulWidget {

  FunkyOverlay({ required this.animationController});

  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay> with SingleTickerProviderStateMixin {
  //late AnimationController controller;
  late Animation<double> scaleAnimation;



  @override
  void initState() {
    super.initState();

    //controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: widget.animationController, curve: Curves.elasticInOut);

    widget.animationController.addListener(() {
      //setState(() {});
    });

    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final diameter = 200.0;
    final iconSize = 40;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
          //  alignment: AlignmentDirectional.bottomCenter,
            children: [

              Container(
               // width: double.infinity,
               // alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight+30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  GestureDetector(onTap:(){
                     context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.listDevise);
                     Navigator.pop(context);
                  }, child: Container(
                  //  height: 76.0,
                    width: 112.0,
                    margin: const EdgeInsets.only(right: 5,),
                    alignment: FractionalOffset.topCenter,
                    child: CustomPaint(
                      size: Size(defaultSizeDevice.width, (defaultSizeDevice.width*0.6333333333333333).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: Form0CustomPainter(),
                      child:Container(alignment: const Alignment(-0.3, 0.2), margin: const EdgeInsets.only(left: 30,), width: 119,
                        height: 76, child: const Image(
                          image: AppAssets.imgExchange,
                          color: AppColors.white,
                          height: 30,
                        ),),),
                  )),

                    GestureDetector(onTap: (){
                      context.read<AppMenuCubit>().setNavBarItem(AppMenuItem.listDevise);
                      Navigator.pop(context);
                  }, child: Container(
                    height: 76.0,
                    width: 112.0,
                    margin: const EdgeInsets.only(left: 4,),
                    alignment: FractionalOffset.topCenter,
                    child: CustomPaint(
                      size: Size(defaultSizeDevice.width, (defaultSizeDevice.width*0.6386554621848739).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: Form1CustomPainter(),
                      child: Container(alignment: const Alignment(-0.9, 0.2), margin: const EdgeInsets.only(left: 30,), width: 119,
                        height: 76, child: const Image(
                          image: AppAssets.imgAnnonce2,
                          color: AppColors.white,
                          height: 30,
                        ),),
                    ),
                  )),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
