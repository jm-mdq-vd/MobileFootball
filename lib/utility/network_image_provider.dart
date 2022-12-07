import 'package:cached_network_image/cached_network_image.dart';

import 'svg_provider.dart';
import '../resources/local_assets.dart';

class NetworkImageProvider {
  static bool isSvg(String url) => url.split('.').last == 'svg';

  static dynamic image(String url) {
    return NetworkImageProvider.isSvg(url) ? SvgProvider.svgFromUrl(
      url,
      placeholder: LocalAssets.countryPlaceholder,
    ) : CachedNetworkImage(
      imageUrl: url,
    );
  }
}