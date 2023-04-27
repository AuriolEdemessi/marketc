
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../../../export.dart';


class ImageSliderWidget extends StatefulWidget {
  final List<String> imageUrls;
  final double imageHeight;

  const ImageSliderWidget({
    Key? key,
    required this.imageUrls,
    this.imageHeight = 350.0,
  }) : super(key: key);

  @override
  ImageSliderWidgetState createState() {
    return new ImageSliderWidgetState();
  }
}

class ImageSliderWidgetState extends State<ImageSliderWidget> {
  List<Widget> _pages = [];

  int page = 0;

  final pageController = LoopPageController();

  @override
  void initState() {
    super.initState();
    _pages = widget.imageUrls.map((url) {
      return _buildImagePageItem(url);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPagerViewSlider();
  }

  Widget _buildingImageSlider() {
    return Stack(
        children: [
          _buildPagerViewSlider(),
         // _buildDotsIndicatorOverlay(),
        ],
      );
  }

  Widget _buildPagerViewSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          enlargeCenterPage: false,
          disableCenter: false
      ),
      items: widget.imageUrls.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _buildImagePageItem(i);
          },
        );
      }).toList(),
    );
  }

 /* Positioned _buildDotsIndicatorOverlay() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new DotsIndicator(
          dotsCount: _pages.length,
         //position: 0,
          position: pageController.page,
          decorator: DotsDecorator(
            color: AppColors.primary1, // Inactive color
            activeColor: AppColors.white,
          ),
        )
        *//*DotsIndicator(
          controller: pageController,
          itemCount: _pages.length,
          onPageSelected: (int page) {
            pageController.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        )*//*,
      ),
    );
  }*/

  Widget _buildImagePageItem(String imgUrl) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            width: 1000.0,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: AppLoadingIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
      ),
    );
  }

}

