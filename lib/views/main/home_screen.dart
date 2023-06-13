import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal/api/endpoints/photo.dart';
import 'package:josequal/api/models/wallpaper_model.dart';
import 'package:josequal/components/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<WallpaperModel> wallpapers = [];

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Loading(),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
            child: GridView.builder(
              itemCount: wallpapers.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150, // Maximum width for each card
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemBuilder: (BuildContext context, int index) {
                final WallpaperModel wallpaper = wallpapers[index];
                final double width = wallpaper.height.toDouble();
                final double height = wallpaper.height.toDouble();
                const Color shadowColor = Colors.black;
                return InkWell(
                  onTap: () => onTapWallpaper(wallpaper),
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent.shade700),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(wallpaper.src.medium),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                shadowColor.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                wallpaper.photographer,
                                style: GoogleFonts.montserrat()
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                shadowColor.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  void onInit() {
    getWallPapers();
  }

  void getWallPapers() async {
    Response response = await WallpapersEndpoints.random();
    if (response.statusCode == 200) {
      setState(() {
        wallpapers = WallpaperModel.fromList(response.data["photos"]);
        isLoading = false;
      });
    }
  }

  void onTapWallpaper(WallpaperModel wallpaperModel) {
    GoRouter.of(context).pushNamed("view", extra: wallpaperModel);
  }
}
