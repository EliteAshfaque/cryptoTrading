import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderView extends StatelessWidget {
  ShimmerLoaderView(
      {super.key,
      this.width,
      this.height,
      this.topLeftRadius,
      this.topRightRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.leftMargin,
      this.rightMargin,
      this.topMargin,
      this.bottomMargin,
      this.widget});

  final double? width;
  final double? height;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double? leftMargin;
  final double? rightMargin;
  final double? topMargin;
  final double? bottomMargin;
  final Widget? widget;
  var gradient =  const LinearGradient(
    colors: [
      Color(0xFFD8D8E3),
      Color(0xFFECECEC),
      Color(0xFFD8D8E3),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        gradient: gradient,
        child: widget ??
            Container(
              margin: EdgeInsets.only(
                  left: leftMargin ?? 0,
                  right: rightMargin ?? 0,
                  top: topMargin ?? 0,
                  bottom: bottomMargin ?? 0),
              width: width??0,
              height: height??0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 0),
                      bottomRight: Radius.circular(bottomRightRadius ?? 0),
                      topLeft: Radius.circular(topLeftRadius ?? 0),
                      topRight: Radius.circular(topRightRadius ?? 0))),
            ));
  }
}
