import 'package:dio/dio.dart';

class ImageDownloadProgress {
  double progress = 0.0;
  double blurValue = 0.0;
  String imageUrl = '';

  ImageDownloadProgress({required this.imageUrl});

  Future<void> downloadImage(void Function() setState) async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(
        imageUrl,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Calculate download progress as a percentage
            progress = (received / total) * 25;
            // Invert progress value to calculate blur
            blurValue = 25 - progress;

            // Update the state to reflect the new progress value
            setState();
          }
        },
      );

      // Image downloaded successfully
      // You can handle the downloaded image as needed
      // For example, save it to a file or display it in your UI
    } catch (e) {
      print('Download Error: $e');
    }
  }
}
