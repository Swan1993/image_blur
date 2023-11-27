library image_blur;

import 'package:flutter/material.dart';
import 'package:image_blur/src/widget/image_download_blur.dart';

import 'widget/image_circular_blur.dart';
import 'widget/image_rectangle_blur.dart';

class ImageBlur {
  static Widget imageRectangleBlur({
    ///Receives images from Image Network
    final String? imageNetwork,

    ///Receives images locally
    final String? imageAssets,

    ///Specifies how long to wait and display the durationShimmer. Default = 3
    int durationShimmer = 3,

    ///Specifies how long to wait and display the durationBlur. Default = 2
    int durationBlur = 2,

    ///If non-null, requires the child to have exactly this height.
    double? height,

    ///If non-null, requires the child to have exactly this width.
    double? width,

    ///Default [BoxFit.cover]
    BoxFit? fit = BoxFit.cover,

    ///Used to combine [color] with this image.
    ///The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is the source and this image is the destination.
    ///See also:
    ///[BlendMode], which includes an illustration of the effect of each blend mode.
    BlendMode? colorBlendMode = BlendMode.srcIn,

    ///If non-null, this color is blended with each image pixel using [colorBlendMode].

    Color? color,

    /// How to align the image within its bounds.

    ///The alignment aligns the given position in the image to the given position in the layout bounds. For example, an [Alignment] alignment of (-1.0, -1.0) aligns the image to the top-left corner of its layout bounds, while an [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the image with the bottom right corner of its layout bounds. Similarly, an alignment of (0.0, 1.0) aligns the bottom middle of the image with the middle of the bottom edge of its layout bounds.

    ///To display a subpart of an image, consider using a [CustomPainter] and [Canvas.drawImageRect].

    ///If the [alignment] is [TextDirection]-dependent (i.e. if it is a [AlignmentDirectional]), then an ambient [Directionality] widget must be in scope.

    ///Defaults to [Alignment.center].

//See also:

    ///[Alignment], a class with convenient constants typically used to specify an [AlignmentGeometry].
    ///[AlignmentDirectional], like [Alignment] for specifying alignments relative to text direction.
    AlignmentGeometry alignment = Alignment.center,

    ///The center slice for a nine-patch image.

    ///The region of the image inside the center slice will be stretched both horizontally and vertically to fit the image into its destination. The region of the image above and below the center slice will be stretched only horizontally and the region of the image to the left and right of the center slice will be stretched only vertically.
    Rect? centerSlice,

    /// If non-null, the value from the [Animation] is multiplied with the opacity
    /// of each image pixel before painting onto the canvas.
    ///
    /// This is more efficient than using [FadeTransition] to change the opacity
    /// of an image, since this avoids creating a new composited layer. Composited
    /// layers may double memory usage as the image is painted onto an offscreen
    /// render target.
    ///
    /// See also:
    ///
    ///  * [AlwaysStoppedAnimation], which allows you to create an [Animation]
    ///    from a single opacity value.
    Animation<double>? opacity,

    /// The rendering quality of the image.
    ///
    /// {@template flutter.widgets.image.filterQuality}
    /// If the image is of a high quality and its pixels are perfectly aligned
    /// with the physical screen pixels, extra quality enhancement may not be
    /// necessary. If so, then [FilterQuality.none] would be the most efficient.
    ///
    /// If the pixels are not perfectly aligned with the screen pixels, or if the
    /// image itself is of a low quality, [FilterQuality.none] may produce
    /// undesirable artifacts. Consider using other [FilterQuality] values to
    /// improve the rendered image quality in this case. Pixels may be misaligned
    /// with the screen pixels as a result of transforms or scaling.
    ///
    /// See also:
    ///
    ///  * [FilterQuality], the enum containing all possible filter quality
    ///    options.
    /// {@endtemplate}
    FilterQuality filterQuality = FilterQuality.low,

    /// How to paint any portions of the layout bounds not covered by the image.
    ImageRepeat repeat = ImageRepeat.noRepeat,

    /// Whether to paint the image in the direction of the [TextDirection].
    ///
    /// If this is true, then in [TextDirection.ltr] contexts, the image will be
    /// drawn with its origin in the top left (the "normal" painting direction for
    /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
    /// a scaling factor of -1 in the horizontal direction so that the origin is
    /// in the top right.
    ///
    /// This is occasionally used with images in right-to-left environments, for
    /// images that were designed for left-to-right locales. Be careful, when
    /// using this, to not flip images with integral shadows, text, or other
    /// effects that will look incorrect when flipped.
    ///
    /// If this is true, there must be an ambient [Directionality] widget in
    /// scope.
    bool matchTextDirection = false,

    /// Whether to continue showing the old image (true), or briefly show nothing
    /// (false), when the image provider changes. The default value is false.
    ///
    /// ## Design discussion
    ///
    /// ### Why is the default value of [gaplessPlayback] false?
    ///
    /// Having the default value of [gaplessPlayback] be false helps prevent
    /// situations where stale or misleading information might be presented.
    /// Consider the following case:
    ///
    /// We have constructed a 'Person' widget that displays an avatar [Image] of
    /// the currently loaded person along with their name. We could request for a
    /// new person to be loaded into the widget at any time. Suppose we have a
    /// person currently loaded and the widget loads a new person. What happens
    /// if the [Image] fails to load?
    ///
    /// * Option A ([gaplessPlayback] = false): The new person's name is coupled
    /// with a blank image.
    ///
    /// * Option B ([gaplessPlayback] = true): The widget displays the avatar of
    /// the previous person and the name of the newly loaded person.
    ///
    /// This is why the default value is false. Most of the time, when you change
    /// the image provider you're not just changing the image, you're removing the
    /// old widget and adding a new one and not expecting them to have any
    /// relationship. With [gaplessPlayback] on you might accidentally break this
    /// expectation and re-use the old widget.
    bool gaplessPlayback = false,

    /// A Semantic description of the image.
    ///
    /// Used to provide a description of the image to TalkBack on Android, and
    /// VoiceOver on iOS.
    String? semanticLabel,

    /// A builder function responsible for creating the widget that represents
    /// this image.
    ///
    /// If this is null, this widget will display an image that is painted as
    /// soon as the first image frame is available (and will appear to "pop" in
    /// if it becomes available asynchronously). Callers might use this builder to
    /// add effects to the image (such as fading the image in when it becomes
    /// available) or to display a placeholder widget while the image is loading.
    ///
    /// To have finer-grained control over the way that an image's loading
    /// progress is communicated to the user, see [loadingBuilder].
    ///
    /// ## Chaining with [loadingBuilder]
    ///
    /// If a [loadingBuilder] has _also_ been specified for an image, the two
    /// builders will be chained together: the _result_ of this builder will
    /// be passed as the `child` argument to the [loadingBuilder]. For example,
    /// consider the following builders used in conjunction:
    ///
    /// {@template flutter.widgets.Image.frameBuilder.chainedBuildersExample}
    /// ```dart
    /// Image(
    ///   image: _image,
    ///   frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
    ///     return Padding(
    ///       padding: const EdgeInsets.all(8.0),
    ///       child: child,
    ///     );
    ///   },
    ///   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    ///     return Center(child: child);
    ///   },
    /// )
    /// ```
    ///
    /// In this example, the widget hierarchy will contain the following:
    ///
    /// ```dart
    /// Center(
    ///   child: Padding(
    ///     padding: const EdgeInsets.all(8.0),
    ///     child: image,
    ///   ),
    /// ),
    /// ```
    /// {@endtemplate}
    ///
    /// {@tool dartpad}
    /// The following sample demonstrates how to use this builder to implement an
    /// image that fades in once it's been loaded.
    ///
    /// This sample contains a limited subset of the functionality that the
    /// [FadeInImage] widget provides out of the box.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.frame_builder.0.dart **
    /// {@end-tool}
    ImageFrameBuilder? frameBuilder,

    /// A builder that specifies the widget to display to the user while an image
    /// is still loading.
    ///
    /// If this is null, and the image is loaded incrementally (e.g. over a
    /// network), the user will receive no indication of the progress as the
    /// bytes of the image are loaded.
    ///
    /// For more information on how to interpret the arguments that are passed to
    /// this builder, see the documentation on [ImageLoadingBuilder].
    ///
    /// ## Performance implications
    ///
    /// If a [loadingBuilder] is specified for an image, the [Image] widget is
    /// likely to be rebuilt on every
    /// [rendering pipeline frame](rendering/RendererBinding/drawFrame.html) until
    /// the image has loaded. This is useful for cases such as displaying a loading
    /// progress indicator, but for simpler cases such as displaying a placeholder
    /// widget that doesn't depend on the loading progress (e.g. static "loading"
    /// text), [frameBuilder] will likely work and not incur as much cost.
    ///
    /// ## Chaining with [frameBuilder]
    ///
    /// If a [frameBuilder] has _also_ been specified for an image, the two
    /// builders will be chained together: the `child` argument to this
    /// builder will contain the _result_ of the [frameBuilder]. For example,
    /// consider the following builders used in conjunction:
    ///
    /// {@macro flutter.widgets.Image.frameBuilder.chainedBuildersExample}
    ///
    /// {@tool dartpad}
    /// The following sample uses [loadingBuilder] to show a
    /// [CircularProgressIndicator] while an image loads over the network.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.loading_builder.0.dart **
    /// {@end-tool}
    ///
    /// Run against a real-world image on a slow network, the previous example
    /// renders the following loading progress indicator while the image loads
    /// before rendering the completed image.
    ///
    /// {@animation 400 400 https://flutter.github.io/assets-for-api-docs/assets/widgets/loading_progress_image.mp4}
    ImageLoadingBuilder? loadingBuilder,

    /// A builder function that is called if an error occurs during image loading.
    ///
    /// If this builder is not provided, any exceptions will be reported to
    /// [FlutterError.onError]. If it is provided, the caller should either handle
    /// the exception by providing a replacement widget, or rethrow the exception.
    ///
    /// {@tool dartpad}
    /// The following sample uses [errorBuilder] to show a '😢' in place of the
    /// image that fails to load, and prints the error to the console.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.error_builder.0.dart **
    /// {@end-tool}
    ImageErrorWidgetBuilder? errorBuilder,

    /// Whether to paint the image with anti-aliasing.

    /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
    bool isAntiAlias = false,
    bool isBlur = true,
    bool isShimmer = true,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return ImageRectangleBlur(
      imageAssets: imageAssets,
      imageNetwork: imageNetwork,
      height: height,
      width: width,
      fit: fit,
      colorBlendMode: colorBlendMode,
      color: color,
      alignment: alignment,
      centerSlice: centerSlice,
      opacity: opacity,
      filterQuality: filterQuality,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      gapLessPlayback: gaplessPlayback,
      semanticLabel: semanticLabel,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      isAntiAlias: isAntiAlias,
      isBlur: isBlur,
      isShimmer: isShimmer,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      headers: headers,
    );
  }

  static Widget imageCircularBlur({
    ///Receives images from Image Network
    final String? imageNetwork,

    ///Receives images locally
    final String? imageAssets,

    ///Specifies how long to wait and display the durationShimmer. Default = 3
    int durationShimmer = 3,

    ///Specifies how long to wait and display the durationBlur. Default = 2
    int durationBlur = 2,

    ///If non-null, requires the child to have exactly this height. Default = 100
    double? size,

    ///Default [BoxFit.cover]
    BoxFit? fit = BoxFit.cover,

    ///Used to combine [color] with this image.
    ///The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is the source and this image is the destination.
    ///See also:
    ///[BlendMode], which includes an illustration of the effect of each blend mode.
    BlendMode? colorBlendMode = BlendMode.srcIn,

    ///If non-null, this color is blended with each image pixel using [colorBlendMode].

    Color? color,

    /// How to align the image within its bounds.

    ///The alignment aligns the given position in the image to the given position in the layout bounds. For example, an [Alignment] alignment of (-1.0, -1.0) aligns the image to the top-left corner of its layout bounds, while an [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the image with the bottom right corner of its layout bounds. Similarly, an alignment of (0.0, 1.0) aligns the bottom middle of the image with the middle of the bottom edge of its layout bounds.

    ///To display a subpart of an image, consider using a [CustomPainter] and [Canvas.drawImageRect].

    ///If the [alignment] is [TextDirection]-dependent (i.e. if it is a [AlignmentDirectional]), then an ambient [Directionality] widget must be in scope.

    ///Defaults to [Alignment.center].

//See also:

    ///[Alignment], a class with convenient constants typically used to specify an [AlignmentGeometry].
    ///[AlignmentDirectional], like [Alignment] for specifying alignments relative to text direction.
    AlignmentGeometry alignment = Alignment.center,

    ///The center slice for a nine-patch image.

    ///The region of the image inside the center slice will be stretched both horizontally and vertically to fit the image into its destination. The region of the image above and below the center slice will be stretched only horizontally and the region of the image to the left and right of the center slice will be stretched only vertically.
    Rect? centerSlice,

    /// If non-null, the value from the [Animation] is multiplied with the opacity
    /// of each image pixel before painting onto the canvas.
    ///
    /// This is more efficient than using [FadeTransition] to change the opacity
    /// of an image, since this avoids creating a new composited layer. Composited
    /// layers may double memory usage as the image is painted onto an offscreen
    /// render target.
    ///
    /// See also:
    ///
    ///  * [AlwaysStoppedAnimation], which allows you to create an [Animation]
    ///    from a single opacity value.
    Animation<double>? opacity,

    /// The rendering quality of the image.
    ///
    /// {@template flutter.widgets.image.filterQuality}
    /// If the image is of a high quality and its pixels are perfectly aligned
    /// with the physical screen pixels, extra quality enhancement may not be
    /// necessary. If so, then [FilterQuality.none] would be the most efficient.
    ///
    /// If the pixels are not perfectly aligned with the screen pixels, or if the
    /// image itself is of a low quality, [FilterQuality.none] may produce
    /// undesirable artifacts. Consider using other [FilterQuality] values to
    /// improve the rendered image quality in this case. Pixels may be misaligned
    /// with the screen pixels as a result of transforms or scaling.
    ///
    /// See also:
    ///
    ///  * [FilterQuality], the enum containing all possible filter quality
    ///    options.
    /// {@endtemplate}
    FilterQuality filterQuality = FilterQuality.low,

    /// How to paint any portions of the layout bounds not covered by the image.
    ImageRepeat repeat = ImageRepeat.noRepeat,

    /// Whether to paint the image in the direction of the [TextDirection].
    ///
    /// If this is true, then in [TextDirection.ltr] contexts, the image will be
    /// drawn with its origin in the top left (the "normal" painting direction for
    /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
    /// a scaling factor of -1 in the horizontal direction so that the origin is
    /// in the top right.
    ///
    /// This is occasionally used with images in right-to-left environments, for
    /// images that were designed for left-to-right locales. Be careful, when
    /// using this, to not flip images with integral shadows, text, or other
    /// effects that will look incorrect when flipped.
    ///
    /// If this is true, there must be an ambient [Directionality] widget in
    /// scope.
    bool matchTextDirection = false,

    /// Whether to continue showing the old image (true), or briefly show nothing
    /// (false), when the image provider changes. The default value is false.
    ///
    /// ## Design discussion
    ///
    /// ### Why is the default value of [gaplessPlayback] false?
    ///
    /// Having the default value of [gaplessPlayback] be false helps prevent
    /// situations where stale or misleading information might be presented.
    /// Consider the following case:
    ///
    /// We have constructed a 'Person' widget that displays an avatar [Image] of
    /// the currently loaded person along with their name. We could request for a
    /// new person to be loaded into the widget at any time. Suppose we have a
    /// person currently loaded and the widget loads a new person. What happens
    /// if the [Image] fails to load?
    ///
    /// * Option A ([gaplessPlayback] = false): The new person's name is coupled
    /// with a blank image.
    ///
    /// * Option B ([gaplessPlayback] = true): The widget displays the avatar of
    /// the previous person and the name of the newly loaded person.
    ///
    /// This is why the default value is false. Most of the time, when you change
    /// the image provider you're not just changing the image, you're removing the
    /// old widget and adding a new one and not expecting them to have any
    /// relationship. With [gaplessPlayback] on you might accidentally break this
    /// expectation and re-use the old widget.
    bool gapLessPlayback = false,

    /// A Semantic description of the image.
    ///
    /// Used to provide a description of the image to TalkBack on Android, and
    /// VoiceOver on iOS.
    String? semanticLabel,

    /// A builder function responsible for creating the widget that represents
    /// this image.
    ///
    /// If this is null, this widget will display an image that is painted as
    /// soon as the first image frame is available (and will appear to "pop" in
    /// if it becomes available asynchronously). Callers might use this builder to
    /// add effects to the image (such as fading the image in when it becomes
    /// available) or to display a placeholder widget while the image is loading.
    ///
    /// To have finer-grained control over the way that an image's loading
    /// progress is communicated to the user, see [loadingBuilder].
    ///
    /// ## Chaining with [loadingBuilder]
    ///
    /// If a [loadingBuilder] has _also_ been specified for an image, the two
    /// builders will be chained together: the _result_ of this builder will
    /// be passed as the `child` argument to the [loadingBuilder]. For example,
    /// consider the following builders used in conjunction:
    ///
    /// {@template flutter.widgets.Image.frameBuilder.chainedBuildersExample}
    /// ```dart
    /// Image(
    ///   image: _image,
    ///   frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
    ///     return Padding(
    ///       padding: const EdgeInsets.all(8.0),
    ///       child: child,
    ///     );
    ///   },
    ///   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    ///     return Center(child: child);
    ///   },
    /// )
    /// ```
    ///
    /// In this example, the widget hierarchy will contain the following:
    ///
    /// ```dart
    /// Center(
    ///   child: Padding(
    ///     padding: const EdgeInsets.all(8.0),
    ///     child: image,
    ///   ),
    /// ),
    /// ```
    /// {@endtemplate}
    ///
    /// {@tool dartpad}
    /// The following sample demonstrates how to use this builder to implement an
    /// image that fades in once it's been loaded.
    ///
    /// This sample contains a limited subset of the functionality that the
    /// [FadeInImage] widget provides out of the box.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.frame_builder.0.dart **
    /// {@end-tool}
    ImageFrameBuilder? frameBuilder,

    /// A builder that specifies the widget to display to the user while an image
    /// is still loading.
    ///
    /// If this is null, and the image is loaded incrementally (e.g. over a
    /// network), the user will receive no indication of the progress as the
    /// bytes of the image are loaded.
    ///
    /// For more information on how to interpret the arguments that are passed to
    /// this builder, see the documentation on [ImageLoadingBuilder].
    ///
    /// ## Performance implications
    ///
    /// If a [loadingBuilder] is specified for an image, the [Image] widget is
    /// likely to be rebuilt on every
    /// [rendering pipeline frame](rendering/RendererBinding/drawFrame.html) until
    /// the image has loaded. This is useful for cases such as displaying a loading
    /// progress indicator, but for simpler cases such as displaying a placeholder
    /// widget that doesn't depend on the loading progress (e.g. static "loading"
    /// text), [frameBuilder] will likely work and not incur as much cost.
    ///
    /// ## Chaining with [frameBuilder]
    ///
    /// If a [frameBuilder] has _also_ been specified for an image, the two
    /// builders will be chained together: the `child` argument to this
    /// builder will contain the _result_ of the [frameBuilder]. For example,
    /// consider the following builders used in conjunction:
    ///
    /// {@macro flutter.widgets.Image.frameBuilder.chainedBuildersExample}
    ///
    /// {@tool dartpad}
    /// The following sample uses [loadingBuilder] to show a
    /// [CircularProgressIndicator] while an image loads over the network.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.loading_builder.0.dart **
    /// {@end-tool}
    ///
    /// Run against a real-world image on a slow network, the previous example
    /// renders the following loading progress indicator while the image loads
    /// before rendering the completed image.
    ///
    /// {@animation 400 400 https://flutter.github.io/assets-for-api-docs/assets/widgets/loading_progress_image.mp4}
    ImageLoadingBuilder? loadingBuilder,

    /// A builder function that is called if an error occurs during image loading.
    ///
    /// If this builder is not provided, any exceptions will be reported to
    /// [FlutterError.onError]. If it is provided, the caller should either handle
    /// the exception by providing a replacement widget, or rethrow the exception.
    ///
    /// {@tool dartpad}
    /// The following sample uses [errorBuilder] to show a '😢' in place of the
    /// image that fails to load, and prints the error to the console.
    ///
    /// ** See code in examples/api/lib/widgets/image/image.error_builder.0.dart **
    /// {@end-tool}
    ImageErrorWidgetBuilder? errorBuilder,

    /// Whether to paint the image with anti-aliasing.

    /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
    bool isAntiAlias = false,
    bool isBlur = true,
    bool isShimmer = true,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return ImageCircularBlur(
      imageAssets: imageAssets,
      imageNetwork: imageNetwork,
      size: size,
      fit: fit,
      colorBlendMode: colorBlendMode,
      color: color,
      alignment: alignment,
      centerSlice: centerSlice,
      opacity: opacity,
      filterQuality: filterQuality,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      gapLessPlayback: gapLessPlayback,
      semanticLabel: semanticLabel,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      isAntiAlias: isAntiAlias,
      isBlur: isBlur,
      isShimmer: isShimmer,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      headers: headers,
    );
  }

  static Widget imageDownloadBlur({
    required final String imageUrl,
    final bool? loadingProgress,
    final BoxFit? fit = BoxFit.cover,
    final double? height,
    final double? width,
    final BlendMode? colorBlendMode,
    final Color? color,
    final Alignment alignment = Alignment.center,
    final Rect? centerSlice,
    final Animation<double>? opacity,
    final FilterQuality filterQuality = FilterQuality.low,
    final ImageRepeat repeat = ImageRepeat.noRepeat,
    final bool matchTextDirection = false,
    final bool gapLessPlayback = false,
    final String? semanticLabel,
    final ImageFrameBuilder? frameBuilder,
    final ImageLoadingBuilder? loadingBuilder,
    final ImageErrorWidgetBuilder? errorBuilder,
    final bool isAntiAlias = false,
    final Map<String, String>? headers,
    final int? cacheWidth,
    final int? cacheHeight,
    final TileMode tileMode = TileMode.decal,
    final Duration fadeInDuration = const Duration(milliseconds: 500),
    final Color backgroundImage = const Color.fromRGBO(238, 238, 238, 1),
    final double scale = 1.0,
    final int? memCacheHeight,
    final int? memCacheWidth,
    final Duration cacheManagerTime = const Duration(minutes: 35),
  }) {
    return ImageDownloadBlur(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      color: color,
      headers: headers,
      alignment: alignment,
      errorBuilder: errorBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      centerSlice: centerSlice,
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
      frameBuilder: frameBuilder,
      gapLessPlayback: gapLessPlayback,
      isAntiAlias: isAntiAlias,
      loadingBuilder: loadingBuilder,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      semanticLabel: semanticLabel,
      tileMode: tileMode,
      fadeInDuration: fadeInDuration,
      backgroundImage: backgroundImage,
      memCacheHeight: memCacheHeight,
      memCacheWidth: memCacheWidth,
      cacheManagerTime: cacheManagerTime,
    );
  }
}
