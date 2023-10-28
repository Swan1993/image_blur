import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/ink_drop.dart';
import '../model/progress_download_model.dart';

class ImageDownloadBlur extends StatefulWidget {
  final String imageUrl;

  final bool? loadingProgress;

  final BoxFit? fit;

  final double? height;

  final double? width;

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

  final Map<String, String>? headers;

  final int? cacheWidth;

  final int? cacheHeight;

  final double loadingIconSize;

  final TileMode tileMode;

  const ImageDownloadBlur(
      {required this.imageUrl,
      super.key,
      this.loadingProgress = true,
      this.fit = BoxFit.cover,
      this.height,
      this.width,
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
      this.headers,
      this.cacheWidth,
      this.cacheHeight,
      this.loadingIconSize = 35,
      this.tileMode = TileMode.decal});

  @override
  // ignore: library_private_types_in_public_api
  _ImageDownloadBlurState createState() => _ImageDownloadBlurState();
}

class _ImageDownloadBlurState extends State<ImageDownloadBlur> {
  ImageDownloadProgress? downloadProgress;

  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 1), () {
      // Initialize the ImageDownloadProgress object
      downloadProgress = ImageDownloadProgress(imageUrl: widget.imageUrl);

      // Start the download
      downloadProgress!.downloadImage(() {
        // The progress value has been updated, so rebuild the UI
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    downloadProgress;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.loadingProgress == true
        ? (downloadProgress == null)
            ? InkDrop(
                color: Theme.of(context).primaryColor,
                size: widget.loadingIconSize,
              )
            : Container(
                color: Colors.grey,
                width: size.width,
                height: size.height,
                child: downloadProgress != null
                    ? ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: downloadProgress!.blurValue,
                          sigmaY: downloadProgress!.blurValue,
                          tileMode: TileMode.decal,
                        ),
                        child: Image.network(
                          downloadProgress!.imageUrl,
                          width: widget.width,
                          height: widget.height,
                          fit: widget.fit,
                          colorBlendMode: widget.colorBlendMode,
                          color: widget.color,
                          alignment: widget.alignment,
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
                    : const SizedBox(),
              )
        : Container(
            color: Colors.grey.shade300,
            width: size.width,
            height: size.height,
            child: downloadProgress != null
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: downloadProgress!.blurValue,
                      sigmaY: downloadProgress!.blurValue,
                      tileMode: widget.tileMode,
                    ),
                    child: Image.network(
                      downloadProgress!.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
          );
  }
}
