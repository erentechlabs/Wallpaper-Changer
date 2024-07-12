import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wallpaper_changer/api/api.dart';
import 'package:wallpaper_changer/widgets/showToast.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Images images;
  final Function refreshImage;
  final Function setImageFuture;

  const SearchBar({super.key, required this.controller, required this.images, required this.refreshImage, required this.setImageFuture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter text',
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              bool hasConnection = await InternetConnectionChecker().hasConnection;
              if (hasConnection) {
                if (controller.text.trim().isNotEmpty) {
                  setImageFuture(images.searchImages(controller.text));
                }
              } else {
                showToast("No Internet Connection");
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}