import 'dart:convert';

import 'package:josequal/api/models/wallpaper_source_model.dart';

class WallpaperModel {
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final String avgColor;
  final WallpaperSourceModel src;
  final bool liked;
  final String alt;

  WallpaperModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json,
      {bool isDb = false}) {
    return WallpaperModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json[isDb ? 'photographerUrl' : 'photographer_url'],
      photographerId: json[isDb ? 'photographerId' : 'photographer_id'],
      avgColor: json[isDb ? 'avgColor' : 'avg_color'],
      src: isDb
          ? WallpaperSourceModel(
              original: json['src'],
              large2x: json['src'],
              large: json['src'],
              medium: json['src'],
              small: json['src'],
              portrait: json['src'],
              landscape: json['src'],
              tiny: json['src'],
            )
          : WallpaperSourceModel.fromJson(json['src']),
      liked: isDb ? false : json['liked'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'width': width,
      'height': height,
      'url': url,
      'photographer': photographer,
      'photographerUrl': photographerUrl,
      'photographerId': photographerId,
      'avgColor': avgColor,
      'src': src.large2x,
      'liked': liked,
      'alt': alt,
    };
  }

  static List<WallpaperModel> fromList(List<dynamic> list) {
    return list.map((item) => WallpaperModel.fromJson(item)).toList();
  }
}
