import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal/api/models/wallpaper_model.dart';
import 'package:josequal/db/app_db.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperDetailsScreen extends StatefulWidget {
  const WallpaperDetailsScreen({super.key, required this.wallpaper});
  final WallpaperModel wallpaper;
  @override
  State<WallpaperDetailsScreen> createState() => _WallpaperDetailsScreenState();
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  bool isFavorite = false;
  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          widget.wallpaper.photographer,
          style: GoogleFonts.montserrat().copyWith(
              color: Colors.deepPurpleAccent.shade100,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              widget.wallpaper.src.large2x,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: addFavorite,
                ),
                ElevatedButton(
                  onPressed: () => downloadImage(widget.wallpaper.src.large),
                  child: const Text('Download Wallpaper'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onInit() {
    isInFavorite();
  }

  void isInFavorite() async {
    WallpaperModel? wallpaperInDb =
        await WallpaperDatabase.getWallpaperById(widget.wallpaper.id);
    if (wallpaperInDb != null) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  void addFavorite() async {
    if (isFavorite) {
      await WallpaperDatabase.deleteWallpaper(widget.wallpaper.id);
    } else {
      await WallpaperDatabase.saveWallpaper(widget.wallpaper);
      setState(() {
        isFavorite = true;
      });
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      final dio = Dio();
      final response = await dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));

      if (response.statusCode == 200) {
        final directory =
            await getTemporaryDirectory(); // or getApplicationDocumentsDirectory() to save it permanently
        final imagePath = '${directory.path}/image.jpg';

        File imageFile = File(imagePath);
        await imageFile.writeAsBytes(response.data);
        showSuccessSnackBar('Image downloaded successfully');
      } else {
        showSuccessSnackBar(
            'Failed to download image. Status code: ${response.statusCode}',
            isError: true);
      }
    } catch (e) {
      showSuccessSnackBar('Error downloading image: $e', isError: false);
    }
  }

  void showSuccessSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: !isError ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
