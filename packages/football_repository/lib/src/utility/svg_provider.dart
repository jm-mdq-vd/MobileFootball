import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

class SvgProvider {
  static final ScalableImageCache _cache = ScalableImageCache(size: 164);

  static ScalableImageWidget svgFromUrl(String url, {Widget? placeholder}) {
    return ScalableImageWidget.fromSISource(
      cache: _cache,
      si: ScalableImageSource.fromSvgHttpUrl(Uri.parse(url)),
      onLoading: (BuildContext context) => placeholder ?? Container(color: Colors.grey,),
      onError: (BuildContext context) => placeholder ?? Container(color: Colors.grey,),
    );
  }
}