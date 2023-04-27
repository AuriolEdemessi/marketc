import 'package:flutter/material.dart';

import '../../../export.dart';

class BottomMenu extends StatefulWidget {
  final AnimationController animationController;
  const BottomMenu({Key? key, required this.animationController}) : super(key: key);

  @override
  BottomMenuState createState() => BottomMenuState();
}



class BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppMenuCubit, AppMenuState>(builder: (context, state) {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.0,
        child: Container(height: 80, child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Column(
                children: [
                  const Image(
                    image: AppAssets.imgHome,
                    width: 30,
                    height: 25,
                  ),
                  state.appMenuItem == AppMenuItem.home
                      ? Expanded(
                      child: SizedBox(
                        height: 16,
                        width: 48,
                        child: CustomPaint(
                          painter: RectanglePainter(),
                        ),
                      ))
                      : Container()
                ],
              ),
              onPressed:()=> setNavBarItem(AppMenuItem.home)

            ),
            IconButton(
              icon: Column(
                children: [
                  const Image(
                    image: AppAssets.imgAnnonce,
                    width: 30,
                    height: 25,
                  ),
                  state.appMenuItem == AppMenuItem.annonce
                      ? Expanded(
                      child: SizedBox(
                        height: 16,
                        width: 48,
                        child: CustomPaint(
                          painter: RectanglePainter(),
                        ),
                      ))
                      : Container()
                ],
              ),
              onPressed: ()=>setNavBarItem(AppMenuItem.annonce),
            ),
            const SizedBox(width: 48.0),
            IconButton(
              icon: Column(
                children: [
                  const Image(
                    image: AppAssets.imgHistorique,
                    width: 30,
                    height: 25,
                  ),
                  state.appMenuItem == AppMenuItem.purchases
                      ? Expanded(
                      child: SizedBox(
                        height: 16,
                        width: 48,
                        child: CustomPaint(
                          painter: RectanglePainter(),
                        ),
                      ))
                      : Container()
                ],
              ),
              onPressed: ()=>setNavBarItem(AppMenuItem.purchases),
            ),
            IconButton(
              icon: Column(
                children: [
                  const Image(
                    image: AppAssets.imgPending,
                    width: 30,
                    height: 25,
                  ),
                  state.appMenuItem == AppMenuItem.sales
                      ? Expanded(
                      child: SizedBox(
                        height: 16,
                        width: 48,
                        child: CustomPaint(
                          painter: RectanglePainter(),
                        ),
                      ))
                      : Container()
                ],
              ),
              onPressed: ()=>setNavBarItem(AppMenuItem.sales),
            ),
          ],
        ),)
      );
    });
  }

  void setNavBarItem(AppMenuItem item) {
    widget.animationController.reset();
    context.read<AppMenuCubit>().setNavBarItem(item);
  }
}
