import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes/ThemeColor.dart';
import 'ErrorImageBuilder.dart';


class CachePlaceHolderImage extends StatelessWidget {
  const CachePlaceHolderImage(
      {super.key, required this.imageUrl,
      required this.errorIconHeight,
      this.fit,
      this.isCached,
      this.imageHeight,
      this.imgaeWidth,
      this.errorContainerHeight,
      this.errorContainerWidth,
      this.errorCustomWidget,
      this.errorColorBackground,
      this.errorColorIcon});

  final String imageUrl;
  final BoxFit? fit;
  final bool? isCached;
  final double? imageHeight;
  final double? imgaeWidth;
  final double? errorContainerHeight;
  final double? errorContainerWidth;
  final double errorIconHeight;
  final Color? errorColorBackground;
  final Color? errorColorIcon;
  final Widget? errorCustomWidget;

  @override
  Widget build(BuildContext context) {
    return (isCached ?? true)
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
                  color: errorColorBackground ?? gray_1,
                  height: errorContainerHeight,
                  width: errorContainerWidth,
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/svg/logo.svg",height: errorIconHeight)
                ),
            fadeInDuration: const Duration(milliseconds: 100),
            fadeOutDuration: const Duration(milliseconds: 100),
            width: imgaeWidth,
            height: imageHeight,
            fit: fit ?? BoxFit.contain,
            errorWidget: (context, url, error) =>errorCustomWidget?? ErrorImageBuilder(
                containerHeight: errorContainerHeight ?? imageHeight,
                containerWidth: errorContainerWidth ?? imgaeWidth,
                iconHeight: errorIconHeight,
                colorBackground: errorColorBackground ?? gray_1,
                colorIcon: errorColorIcon ?? gray_3))
        : Image.network(imageUrl,
            width: imgaeWidth,
            height: imageHeight,
            fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) {
            return errorCustomWidget??ErrorImageBuilder(
                containerHeight: errorContainerHeight ?? imageHeight,
                containerWidth: errorContainerWidth ?? imgaeWidth,
                iconHeight: errorIconHeight,
                colorBackground: errorColorBackground ?? gray_1,
                colorIcon: errorColorIcon ?? gray_3);
          });

    /*Container(
      color: colorBackground ?? gray_1,
      height: containerHeight,
      width: containerWidth,
      alignment: Alignment.center,
      child: Image.asset(
        "assets/app_logo_white.png",
        color: colorIcon ?? gray_3,
        height: iconHeight,
      ),
    );*/
  }
}
