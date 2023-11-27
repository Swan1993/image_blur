import 'package:flutter/material.dart';
import 'package:image_blur/image_blur.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ImageBlur.imageCircularBlur(
              imageNetwork:
                  "https://img.freepik.com/free-photo/vivid-colored-transparent-autumn-leaf_23-2148239739.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais"),
        ),
      ),
    );
  }
}
