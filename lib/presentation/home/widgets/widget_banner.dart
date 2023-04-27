import 'dart:async';

import 'package:marketscc/export.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatefulWidget {
  final List<String> _images;
  final double height;
  final ValueChanged<int>? onTap;
  final Curve curve;

  const CustomBanner(
    this._images, {
    this.height = 200,
    this.onTap,
    this.curve = Curves.linear,
  });

  @override
  CustomBannerState createState() => CustomBannerState();
}

class CustomBannerState extends State<CustomBanner> {
  late PageController _pageController;
  late int _curIndex;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _curIndex = widget._images.length * 5;
    _pageController = PageController(initialPage: _curIndex);
    _initTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildPageView(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    var length = widget._images.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget._images.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipOval(
              child: Container(
                width: 8,
                height: 8,
                color: s == widget._images[_curIndex % length]
                    ? AppColors.primary
                    : AppColors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPageView() {
    var length = widget._images.length;
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _curIndex = index;
            if (index == 0) {
              _curIndex = length;
              _changePage();
            }
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (details) {
              _cancelTimer();
            },
            onTap: () {

            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget._images[index % length],
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
      ),
    );
  }

  /// 点击到图片的时候取消定时任务
  _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      _initTimer();
    }
  }

  /// 初始化定时任务
  _initTimer() {

    _timer ??= Timer.periodic(const Duration(seconds: 3), (t) {
      _curIndex++;
      _pageController.animateToPage(
        _curIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  /// 切换页面，并刷新小圆点
  _changePage() {
    if (_pageController.hasClients) {
      return Timer(const Duration(milliseconds: 350), () {
        _pageController.jumpToPage(_curIndex);
      });
    }
    return false;
  }
}
