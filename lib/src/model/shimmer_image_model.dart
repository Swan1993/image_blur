import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerImage({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
