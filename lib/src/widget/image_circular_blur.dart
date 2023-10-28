import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/shimmer_image_model.dart';

class ImageCircularBlur extends StatelessWidget {
  final String? imageNetwork;

  final String? imageAssets;

  final int durationShimmer;

  final int durationBlur;

  final double? size;

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

  final Map<String, String>? headers;

  final int? cacheWidth;

  final int? cacheHeight;

  const ImageCircularBlur({
    super.key,
    this.imageNetwork,
    this.imageAssets,
    this.durationShimmer = 2,
    this.durationBlur = 2,
    this.size,
    this.fit = BoxFit.cover,
    this.colorBlendMode = BlendMode.srcIn,
    this.color,
    this.alignment = Alignment.center,
    this.centerSlice,
    this.opacity,
    this.errorBuilder,
    this.filterQuality = FilterQuality.low,
    this.frameBuilder,
    this.gapLessPlayback = false,
    this.loadingBuilder,
    this.matchTextDirection = false,
    this.repeat = ImageRepeat.noRepeat,
    this.semanticLabel,
    this.isAntiAlias = false,
    this.isBlur = true,
    this.isShimmer = true,
    this.cacheHeight,
    this.cacheWidth,
    this.headers,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
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
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : Image.network(
                                          imageNetwork!,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
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
                          ? Container(
                              color: Colors.grey.shade300,
                              child: Image.network(
                                imageNetwork!,
                                fit: BoxFit.cover,
                                colorBlendMode: colorBlendMode,
                                color: color,
                                alignment: alignment,
                                height: size,
                                width: size,
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
                              ),
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              child: Image.asset(
                                imageAssets!,
                                fit: BoxFit.cover,
                                colorBlendMode: colorBlendMode,
                                color: color,
                                alignment: alignment,
                                height: size,
                                width: size,
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
                              ),
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
      ),
    );
  }
}
