import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wallpaper_changer/widgets/image_card.dart';
import 'package:wallpaper_changer/widgets/search_bar.dart' as search;
import 'package:wallpaper_changer/api/api.dart';
import 'package:wallpaper_changer/api/wallpaper.dart';

import '../widgets/showToast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  late final WallpaperHelper wallpaperHelper = WallpaperHelper();
  late final Images images = Images();
  Future<Uri>? imageFuture;

  @override
  void initState() {
    super.initState();
    checkInternetAndRefreshImage();
  }

  Future<void> checkInternetAndRefreshImage() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (hasConnection) {
      refreshImage();
    } else {
      showToast("No Internet Connection");
    }
  }

  void refreshImage() {
    setState(() {
      controller.clear();
      imageFuture = images.randomImages();
    });
  }

  void setImageFuture(Future<Uri> future) {
    setState(() {
      imageFuture = future;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              checkInternetAndRefreshImage();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ImageCard(imageFuture: imageFuture),
      ),
      bottomNavigationBar: search.SearchBar(controller: controller, images: images, refreshImage: refreshImage, setImageFuture: setImageFuture),
    );
  }
}
