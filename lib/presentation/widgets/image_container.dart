import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/app_loading_indicator.dart';
class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.url, this.margin}) : super(key: key);
  final String url;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:margin?? EdgeInsets.only(
          right: 5,
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          width: 20,
          height: 20,
          imageUrl:url,
          placeholder: (context, url) => Center(child: AppLoadingIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      //child:  Image.asset("assets/images/bitcoin.png", height: 25, width: 25,),
    );
  }
}
