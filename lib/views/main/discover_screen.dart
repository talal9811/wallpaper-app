import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:josequal/api/endpoints/photo.dart';
import 'package:josequal/api/models/wallpaper_model.dart';
import 'package:josequal/components/loading.dart';
import 'package:josequal/components/search.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool isLoading = true;
  List<WallpaperModel> wallpapers = [];
  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(onChanged: onChangeDiscover),
        Expanded(
            child: isLoading
                ? const Center(
                    child: Loading(),
                  )
                : wallpapers.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                        child: GridView.builder(
                          itemCount: wallpapers.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 160,
                                  mainAxisSpacing: 16),
                          itemBuilder: (BuildContext context, int index) {
                            final WallpaperModel wallpaper = wallpapers[index];
                            final double width = wallpaper.height.toDouble();
                            final double height = wallpaper.height.toDouble();
                            return Stack(
                              children: [
                                Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.blueGrey.shade900),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(wallpaper.src.large),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text("No Items Found"),
                      ))
      ],
    );
  }

  void onInit() {
    setState(() {
      isLoading = false;
    });
  }

  void onChangeDiscover(String val) async {
    setState(() {
      isLoading = true;
      wallpapers = [];
    });
    Response response = await WallpapersEndpoints.discover(val);
    if (response.statusCode == 200) {
      setState(() {
        wallpapers = WallpaperModel.fromList(response.data["photos"]);
        isLoading = false;
      });
    }
  }
}
