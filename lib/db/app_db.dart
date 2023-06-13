import 'package:josequal/api/models/wallpaper_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class WallpaperDatabase {
  static final WallpaperDatabase instance = WallpaperDatabase._init();

  static Database? _database;

  WallpaperDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('wallpaperDBA.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = await getDatabasesPath();
    final dbPath = join(path, filePath);

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE wallpapers(
        id INTEGER PRIMARY KEY,
        width INTEGER,
        height INTEGER,
        url TEXT,
        photographer TEXT,
        photographerUrl TEXT,
        photographerId INTEGER,
        avgColor TEXT,
        src TEXT,
        liked INTEGER,
        alt TEXT
      )
    ''');
  }

  static Future<int> saveWallpaper(WallpaperModel wallpaper) async {
    final db = await instance.database;
    return await db.insert('wallpapers', wallpaper.toJson());
  }

  static Future<int> deleteWallpaper(int id) async {
    final db = await instance.database;
    return await db.delete('wallpapers', where: 'id = ?', whereArgs: [id]);
  }

  static Future<WallpaperModel?> getWallpaperById(int id) async {
    final db = await instance.database;
    final maps = await db.query('wallpapers', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return WallpaperModel.fromJson(maps.first, isDb: true);
    }

    return null;
  }

  static Future<List<WallpaperModel>> getAllWallpapers() async {
    final db = await instance.database;
    final maps = await db.query('wallpapers');

    return List.generate(maps.length, (index) {
      return WallpaperModel.fromJson(maps[index], isDb: true);
    });
  }
}
