import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final double height;
  final double width;
  final Color baseColorShimmer;
  final Color highlightColorShimmer;
  final Color colorShimmer;

  const ShimmerImage({
    Key? key,
    required this.height,
    required this.width,
    required this.baseColorShimmer,
    required this.highlightColorShimmer,
    required this.colorShimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColorShimmer,
      highlightColor: highlightColorShimmer,
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
          color: colorShimmer,
        ),
      ),
    );
  }
}
