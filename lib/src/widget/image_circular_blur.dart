import 'dart:ui';

import 'package:flutter/material.dart';
import '../tools/shimmer_image_tools.dart';

class ImageCircularBlur extends StatefulWidget {
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

  final Color baseColorShimmer;

  final Color highlightColorShimmer;

  final Color colorShimmer;

  const ImageCircularBlur(
      {super.key,
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
      this.baseColorShimmer = const Color.fromRGBO(224, 224, 224, 1),
      this.highlightColorShimmer = const Color.fromRGBO(245, 245, 245, 1),
      this.colorShimmer = Colors.white});

  @override
  State<ImageCircularBlur> createState() => _ImageCircularBlurState();
}

class _ImageCircularBlurState extends State<ImageCircularBlur>
    with SingleTickerProviderStateMixin {
  late AnimationController blurController;
  late Animation<double> sigmaXAnimation;

  @override
  void initState() {
    blurController = AnimationController(
        duration: Duration(seconds: widget.durationBlur), vsync: this);
    sigmaXAnimation = Tween<double>(begin: 5, end: 0.0).animate(blurController);
    super.initState();
  }

  @override
  void dispose() {
    blurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: FutureBuilder(
          future: Future.delayed(
              Duration(seconds: widget.isShimmer ? widget.durationShimmer : 0),
              () => true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return widget.isShimmer
                  ? ShimmerImage(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      baseColorShimmer: widget.baseColorShimmer,
                      colorShimmer: widget.colorShimmer,
                      highlightColorShimmer: widget.highlightColorShimmer,
                    )
                  : const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                future: Future.delayed(
                    Duration(seconds: widget.isBlur ? widget.durationBlur : 0),
                    () => true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return widget.isBlur
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              (widget.imageAssets != null ||
                                      widget.imageNetwork != null)
                                  ? (widget.imageAssets != null
                                      ? Image.asset(
                                          widget.imageAssets!,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : Image.network(
                                          widget.imageNetwork!,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ))
                                  : const Text("Image not provided"),
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: sigmaXAnimation.value,
                                    sigmaY: sigmaXAnimation.value,
                                    tileMode: TileMode.decal,
                                  ),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (widget.imageNetwork != null ||
                        widget.imageAssets != null) {
                      return (widget.imageNetwork != null
                          ? Container(
                              color: Colors.grey.shade300,
                              child: Image.network(
                                widget.imageNetwork!,
                                fit: BoxFit.cover,
                                colorBlendMode: widget.colorBlendMode,
                                color: widget.color,
                                alignment: widget.alignment,
                                height: widget.size,
                                width: widget.size,
                                centerSlice: widget.centerSlice,
                                errorBuilder: widget.errorBuilder,
                                filterQuality: widget.filterQuality,
                                frameBuilder: widget.frameBuilder,
                                gaplessPlayback: widget.gapLessPlayback,
                                isAntiAlias: widget.isAntiAlias,
                                loadingBuilder: widget.loadingBuilder,
                                opacity: widget.opacity,
                                semanticLabel: widget.semanticLabel,
                                repeat: widget.repeat,
                                matchTextDirection: widget.matchTextDirection,
                                cacheHeight: widget.cacheHeight,
                                cacheWidth: widget.cacheWidth,
                                headers: widget.headers,
                              ),
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              child: Image.asset(
                                widget.imageAssets!,
                                fit: BoxFit.cover,
                                colorBlendMode: widget.colorBlendMode,
                                color: widget.color,
                                alignment: widget.alignment,
                                height: widget.size,
                                width: widget.size,
                                centerSlice: widget.centerSlice,
                                errorBuilder: widget.errorBuilder,
                                filterQuality: widget.filterQuality,
                                frameBuilder: widget.frameBuilder,
                                gaplessPlayback: widget.gapLessPlayback,
                                isAntiAlias: widget.isAntiAlias,
                                opacity: widget.opacity,
                                semanticLabel: widget.semanticLabel,
                                repeat: widget.repeat,
                                matchTextDirection: widget.matchTextDirection,
                                cacheHeight: widget.cacheHeight,
                                cacheWidth: widget.cacheWidth,
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
