// ignore_for_file: unused_import
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/favorite.dart';
import '../const/const.dart';

class Favoritedb {
  static Future<Database> openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), FavFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $FavTableName(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  static Future<void> Create(Favorite fav) async {
    var db = await openDB();
    await db.insert(
      FavTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Favorite>> Read() async {
    var db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(FavTableName);
    return List.generate(maps.length, (index) {
      return Favorite(
        entityId: maps[index]['id'],
      );
    });
  }

  static Future<void> Delete(int entityId) async {
    var db = await openDB();
    await db.delete(
      FavTableName,
      where: 'id = ?',
      whereArgs: [entityId]
    );
  }
}