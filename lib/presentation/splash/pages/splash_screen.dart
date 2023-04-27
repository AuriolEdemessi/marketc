import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   /* SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SplashScreenCubit>().getAuthState();
    });*/
    Future.microtask(() {
      context.read<SplashScreenCubit>().getAuthState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SplashScreenCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          if (state.response == AuthState.unknown){
            nextRoute(RoutePaths.introScreen);
          } else if (state.response == AuthState.authenticated) {
            nextRoute(RoutePaths.dashboardScreen);
          } else if (state.response == AuthState.unauthenticated) {
            nextRoute(RoutePaths.loginScreen);
          }
        }else if(state is FailureState){
          nextRoute(RoutePaths.loginScreen);
        }
        return Scaffold(
            backgroundColor: AppColors.white,
            body: SizedBox(
                width: double.infinity,
                //height: defaultSizeDevice.height * 3,
                child: CustomPaint(
                  size: Size(defaultSizeDevice.width, (defaultSizeDevice.width*2.1595744680851063).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                  child: Stack(
                    alignment: Alignment.center,
                    children:  <Widget>[
                      Align( child: Container(
                          width: 100,
                          height: 100,
                          decoration:  const BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                          child:  const Padding(padding: EdgeInsets.all(20), child: Image(
                            image: AppAssets.imgLogo512,
                            height: 50,
                            width: 50,
                          ),)),),
                      const SizedBox(
                        height: 120.0,
                        width: 120.0,
                        child:  CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      Positioned(bottom: 0, child: Padding(padding: const EdgeInsets.only(bottom: 50), child: Text("© Marketscc ${DateTime.now().year}", style: kSubtitle2.copyWith(color: AppColors.primary.withOpacity(0.9)),),))
                    ],
                  ),

                )
            )
        );
      },
    ),);
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(0,0,size.width*1.000824,size.height),bottomRight: Radius.circular(size.width*0.07015120),bottomLeft:  Radius.circular(size.width*0.07015120),topLeft:  Radius.circular(size.width*0.07015120),topRight:  Radius.circular(size.width*0.07015120)),paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*-0.007934507,size.height*0.6594298);
    path_1.lineTo(size.width*-0.007926267,size.height*0.6606860);
    path_1.cubicTo(size.width*-0.01105712,size.height*0.6596687,size.width*-0.01219573,size.height*0.6589618,size.width*-0.007934507,size.height*0.6594298);
    path_1.lineTo(size.width*-0.01169173,size.height*0.08797931);
    path_1.cubicTo(size.width*-0.002905653,size.height*0.07449163,size.width*0.03048160,size.height*0.04751638,size.width*0.09374133,size.height*0.04751638);
    path_1.lineTo(size.width*0.9164960,size.height*0.04751638);
    path_1.cubicTo(size.width*0.9485013,size.height*0.04959138,size.width*1.012515,size.height*0.06043337,size.width*1.012515,size.height*0.08720111);
    path_1.lineTo(size.width*1.012515,size.height*0.6848079);
    path_1.cubicTo(size.width*0.9980800,size.height*0.6757291,size.width*0.9202320,size.height*0.6397475,size.width*0.8464267,size.height*0.6353904);
    path_1.cubicTo(size.width*0.7310880,size.height*0.6285800,size.width*0.6547973,size.height*0.6497919,size.width*0.4947627,size.height*0.6739138);
    path_1.cubicTo(size.width*0.3347307,size.height*0.6980357,size.width*0.2104709,size.height*0.7050394,size.width*0.08809307,size.height*0.6785825);
    path_1.cubicTo(size.width*0.02507760,size.height*0.6649594,size.width*-0.0002375003,size.height*0.6602771,size.width*-0.007934507,size.height*0.6594298);
    path_1.close();

    Paint paint1Fill = Paint()..style=PaintingStyle.fill;
    paint1Fill.color = const Color(0xffDAE0EC).withOpacity(1.0);
    canvas.drawPath(path_1,paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*1.020451,size.height*0.6119138);
    path_2.lineTo(size.width*1.020443,size.height*0.6131687);
    path_2.cubicTo(size.width*1.023573,size.height*0.6121527,size.width*1.024712,size.height*0.6114458,size.width*1.020451,size.height*0.6119138);
    path_2.lineTo(size.width*1.024208,size.height*0.04046293);
    path_2.cubicTo(size.width*1.015421,size.height*0.02697525,size.width*0.9820347,0,size.width*0.9187733,0);
    path_2.lineTo(size.width*0.09601973,0);
    path_2.cubicTo(size.width*0.06401333,size.height*0.002075025,size.width*3.878267e-7,size.height*0.01291700,size.width*3.878267e-7,size.height*0.03968485);
    path_2.lineTo(size.width*3.878267e-7,size.height*0.6372906);
    path_2.cubicTo(size.width*0.01443472,size.height*0.6282131,size.width*0.09228480,size.height*0.5922315,size.width*0.1660880,size.height*0.5878732);
    path_2.cubicTo(size.width*0.2814267,size.height*0.5810640,size.width*0.3577200,size.height*0.6022746,size.width*0.5177520,size.height*0.6263978);
    path_2.cubicTo(size.width*0.6777840,size.height*0.6505197,size.width*0.8020453,size.height*0.6575222,size.width*0.9244240,size.height*0.6310665);
    path_2.cubicTo(size.width*0.9874373,size.height*0.6174433,size.width*1.012755,size.height*0.6127599,size.width*1.020451,size.height*0.6119138);
    path_2.close();

    Paint paint2Fill = Paint()..style=PaintingStyle.fill;
    paint2Fill.color = const Color(0xffA7C1E2).withOpacity(1.0);
    canvas.drawPath(path_2,paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width*-0.007934507,size.height*0.5935554);
    path_3.lineTo(size.width*-0.007926267,size.height*0.5948103);
    path_3.cubicTo(size.width*-0.01105712,size.height*0.5937931,size.width*-0.01219573,size.height*0.5930862,size.width*-0.007934507,size.height*0.5935554);
    path_3.lineTo(size.width*-0.01169173,size.height*0.02210431);
    path_3.cubicTo(size.width*-0.002905653,size.height*0.008616626,size.width*0.03048160,size.height*-0.01835862,size.width*0.09374133,size.height*-0.01835862);
    path_3.lineTo(size.width*0.9164960,size.height*-0.01835862);
    path_3.cubicTo(size.width*0.9485013,size.height*-0.01628362,size.width*1.012515,size.height*-0.005441638,size.width*1.012515,size.height*0.02132611);
    path_3.lineTo(size.width*1.012515,size.height*0.6189323);
    path_3.cubicTo(size.width*0.9980800,size.height*0.6098547,size.width*0.9202320,size.height*0.5738719,size.width*0.8464267,size.height*0.5695148);
    path_3.cubicTo(size.width*0.7310880,size.height*0.5627044,size.width*0.6547973,size.height*0.5839163,size.width*0.4947627,size.height*0.6080382);
    path_3.cubicTo(size.width*0.3347307,size.height*0.6321613,size.width*0.2104709,size.height*0.6391638,size.width*0.08809307,size.height*0.6127069);
    path_3.cubicTo(size.width*0.02507760,size.height*0.5990837,size.width*-0.0002375005,size.height*0.5944015,size.width*-0.007934507,size.height*0.5935554);
    path_3.close();

    Paint paint3Fill = Paint()..style=PaintingStyle.fill;
    paint3Fill.shader = ui.Gradient.linear(Offset(size.width*0.5004107,size.height*-1.835862), Offset(size.width*0.5004107,size.height*0.6295899), [const Color(0xff1E1F3E).withOpacity(1),const Color(0xff22255A).withOpacity(1)], [0,1]);
    canvas.drawPath(path_3,paint3Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Future<void> nextRoute(routePath) async {
  await 2.delay();
  Get.offAllNamed(routePath);
}