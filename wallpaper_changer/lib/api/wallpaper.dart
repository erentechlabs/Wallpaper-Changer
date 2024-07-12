import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class WallpaperHelper {
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  WallpaperHelper();

  Future<void> downloadAndApplyWallpaper(String imageUrl, int applyType) async {
    // Download the image
    var response = await http.get(Uri.parse(imageUrl));
    var bytes = response.bodyBytes;

    // Decode the image
    img.Image? image = img.decodeImage(bytes);

    // Get screen dimensions
    Size size = view.physicalSize;
    double width = size.width;
    double height = size.height;


    // Resize the image using linear interpolation for higher quality
    img.Image? resizedImage = img.copyResize(image!, width: width.toInt(), height: height.toInt(), interpolation: img.Interpolation.linear);

    // Get the temporary directory to store the downloaded image
    var tempDir = await getTemporaryDirectory();
    var file = await File('${tempDir.path}/image.jpg').create();

    // Write the resized image to the file
    await file.writeAsBytes(img.encodeJpg(resizedImage));

    int location;
    switch (applyType) {
      case 0:
        location = WallpaperManager.LOCK_SCREEN; // Lock Screen
        break;
      case 1:
        location = WallpaperManager.HOME_SCREEN; // Home Screen
        break;
      default:
        location = WallpaperManager.BOTH_SCREEN; // Both Screens
        break;
    }

    await WallpaperManager.setWallpaperFromFile(file.path, location); //provide image path

    // Delete the file after setting it as wallpaper
    if (await file.exists()) {
      await file.delete();
    }

  }
}