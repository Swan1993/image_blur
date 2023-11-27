import 'package:flutter/material.dart';
import 'package:image_blur/image_blur.dart';
import 'package:t3/screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<String> imageUrls = <String>[
    "https://img.freepik.com/free-photo/pier-lake-hallstatt-austria_181624-44201.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/abstract-autumn-beauty-multi-colored-leaf-vein-pattern-generated-by-ai_188544-9871.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/trees-drawn_1160-909.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/breathtaking-shot-beautiful-stones-turquoise-water-lake-hills-background_181624-12847.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/transparent-vivid-autumn-leaves_23-2148239689.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/view-old-tree-lake-with-snow-covered-mountains-cloudy-day_181624-28954.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/old-rusty-fishing-boat-slope-along-shore-lake_181624-44902.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/beautiful-nature-landscape-with-mountains-lake_23-2150705947.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/trees-drawn_1160-909.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/beautiful-mountain-lake-background-remix_53876-125213.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/closeup-yellow-leaves-branch-with-blue-blurred-background_181624-2238.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/vivid-colored-transparent-autumn-leaf_23-2148239739.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/morskie-oko-tatry_1204-510.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/boat-lake_1121-38.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/selective-focus-shot-brown-leaves-tree-branch-maksimir-park-zagreb-croatia_181624-24554.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/vivid-colored-transparent-fall-leaves_23-2148239737.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/vestrahorn-mountains-stokksnes-iceland_335224-667.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/purple-green-leaves-plant-perfect-backgroun_181624-57075.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/vivid-colored-transparent-autumn-leaves_23-2148239738.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/vertical-shot-beach-during-sunset_181624-31825.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/transparent-droplets-watery-orange-backdrop_23-2148290044.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
    "https://img.freepik.com/free-photo/grunge-style-watercolour-texture-background_1048-7931.jpg?size=626&ext=jpg&uid=R22994307&ga=GA1.1.1899687920.1695643728&semt=ais",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              mainAxisExtent: 120,
            ),
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ImageBlur.imageRectangleBlur(
                  imageNetwork: imageUrls[index],
                  cacheHeight: 1000,
                  cacheWidth: 1000,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Screen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
