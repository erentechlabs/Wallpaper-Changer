import 'dart:math';
import 'package:pexels_api/pexels_api.dart';

class Images
{
  var client = PexelsClient("API_KEY");

  Future<Uri> searchImages(String query) async
  {
    var result = await client.searchPhotos(query, collection: PexelsCollection.Regular, orientation: PexelsPhotoOrientation.portrait);
    if(result == null)
    {
      throw Exception("Photo is null");
    }
    else
    {
      int number = Random().nextInt(result.totalResults!).clamp(0, result.items.length - 1);
      String? photo = result.items[number]!.sources["original"]!.link;
      if (photo == null)
      {
        throw Exception("Photo is null");
      }

      return Uri.parse(photo);
    }

  }

  Future<Uri> randomImages() async
  {

    var result = await client.getPhoto();
    String? photo = result!.sources["original"]!.link;

    if (photo == null)
    {
      throw Exception("Photo is null");
    }
    return Uri.parse(photo);

  }
}