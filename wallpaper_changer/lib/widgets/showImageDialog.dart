import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wallpaper_changer/widgets/showToast.dart';

import '../api/wallpaper.dart';

Future<void> showImageDialog(BuildContext context, String imageUrl) async {
  late final WallpaperHelper wallpaperHelper = WallpaperHelper();

  bool hasConnection = await InternetConnectionChecker().hasConnection;
  if (hasConnection) {
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: isLoading ? const Center(child: Text('Wallpaper is being applied')) : const Center(child: Text('Where to apply')),
              actions: <Widget>[
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.lock),
                              onPressed: () async {
                                setState(() {isLoading = true;});
                                await wallpaperHelper.downloadAndApplyWallpaper(imageUrl, 0);
                                setState(() {isLoading = false;});
                                Navigator.pop(context);
                              },
                            ),
                            const Text('Lock'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.phone_android),
                              onPressed: () async {
                                setState(() {isLoading = true;});
                                await wallpaperHelper.downloadAndApplyWallpaper(imageUrl, 1);
                                setState(() {isLoading = false;});
                                Navigator.pop(context);
                              },
                            ),
                            const Text('Home'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.smartphone),
                              onPressed: () async {
                                setState(() {isLoading = true;});
                                await wallpaperHelper.downloadAndApplyWallpaper(imageUrl, 2);
                                setState(() {isLoading = false;});
                                Navigator.pop(context);
                              },
                            ),
                            const Text('Both'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  } else {
    showToast("No Internet Connection");
  }
}