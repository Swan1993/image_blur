import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/shimmer_image_model.dart';

// ignore: must_be_immutable
class ImageRectangleBlur extends StatelessWidget {
  final String? imageNetwork;

  final String? imageAssets;

  final int durationShimmer;

  final int durationBlur;

  final double? height;

  final double? width;

  final BoxFit? fit;

  final BlendMode? colorBlendMode;

  final Color? color;

  final AlignmentGeometry alignment;

  final Rect? centerSlice;

  final Animation<double>? opacity;

  final FilterQuality filterQuality;

  final ImageRepeat repeat;

  final bool matchTextDirection;

  final bool gapLessPlayback;

  final String? semanticLabel;

  final ImageFrameBuilder? frameBuilder;

  final ImageLoadingBuilder? loadingBuilder;

  final ImageErrorWidgetBuilder? errorBuilder;

  final bool isAntiAlias;

  final bool isBlur;

  final bool isShimmer;

  Map<String, String>? headers;

  int? cacheWidth;

  int? cacheHeight;

  ImageRectangleBlur({
    Key? key,
    this.imageNetwork,
    this.imageAssets,
    this.durationShimmer = 3,
    this.durationBlur = 2,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.colorBlendMode = BlendMode.srcIn,
    this.color,
    this.alignment = Alignment.center,
    this.centerSlice,
    this.opacity,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.gapLessPlayback = false,
    this.semanticLabel,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.isAntiAlias = false,
    this.isBlur = true,
    this.isShimmer = true,
    this.headers,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FutureBuilder(
        future: Future.delayed(
            Duration(seconds: isShimmer ? durationShimmer : 0), () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isShimmer
                ? ShimmerImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  )
                : const SizedBox.shrink();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: Future.delayed(
                  Duration(seconds: isBlur ? durationBlur : 0), () => true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return isBlur
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            (imageAssets != null || imageNetwork != null)
                                ? (imageAssets != null
                                    ? Image.asset(
                                        imageAssets!,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      )
                                    : Image.network(
                                        imageNetwork!,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ))
                                : const Text("Image not provided"),
                            BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY: 5.0,
                                tileMode: TileMode.decal,
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (imageNetwork != null || imageAssets != null) {
                    return (imageNetwork != null
                        ? Image.network(
                            imageNetwork!,
                            fit: BoxFit.cover,
                            colorBlendMode: colorBlendMode,
                            color: color,
                            alignment: alignment,
                            height: height,
                            width: width,
                            centerSlice: centerSlice,
                            errorBuilder: errorBuilder,
                            filterQuality: filterQuality,
                            frameBuilder: frameBuilder,
                            gaplessPlayback: gapLessPlayback,
                            isAntiAlias: isAntiAlias,
                            loadingBuilder: loadingBuilder,
                            opacity: opacity,
                            semanticLabel: semanticLabel,
                            repeat: repeat,
                            matchTextDirection: matchTextDirection,
                            cacheHeight: cacheHeight,
                            cacheWidth: cacheWidth,
                            headers: headers,
                          )
                        : Image.asset(
                            imageAssets!,
                            fit: BoxFit.cover,
                            colorBlendMode: colorBlendMode,
                            color: color,
                            alignment: alignment,
                            height: height,
                            width: width,
                            centerSlice: centerSlice,
                            errorBuilder: errorBuilder,
                            filterQuality: filterQuality,
                            frameBuilder: frameBuilder,
                            gaplessPlayback: gapLessPlayback,
                            isAntiAlias: isAntiAlias,
                            opacity: opacity,
                            semanticLabel: semanticLabel,
                            repeat: repeat,
                            matchTextDirection: matchTextDirection,
                            cacheHeight: cacheHeight,
                            cacheWidth: cacheWidth,
                          ));
                  } else {
                    return const Text("Image not provided");
                  }
                } else {
                  return Text("${snapshot.error}");
                }
              },
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            return Container();
          } else {
            return Text("${snapshot.error}");
          }
        },
      ),
    );
  }
}
