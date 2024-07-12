import 'package:flutter/material.dart';
import 'package:wallpaper_changer/widgets/showImageDialog.dart';

class ImageCard extends StatelessWidget {
  final Future<Uri>? imageFuture;

  const ImageCard({super.key, required this.imageFuture});
  @override
  Widget build(BuildContext context) {

    bool canWallpaper = true;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FutureBuilder<Uri>(
          future: imageFuture,
          builder: (BuildContext context, AsyncSnapshot<Uri> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return MaterialButton(
                  onPressed: () {
                    if(canWallpaper == true) { showImageDialog(context, snapshot.data.toString()); }
                  },
                  onLongPress: () {
                    if(canWallpaper == true) { showImageDialog(context, snapshot.data.toString()); }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            canWallpaper = false;
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error, size: 64),
                                Text("Photo not found")
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Text('No image available');
              }
            }
          },
        ),
      ),
    );
  }
}