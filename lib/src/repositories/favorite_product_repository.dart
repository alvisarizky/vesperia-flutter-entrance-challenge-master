import 'package:entrance_test/src/models/favorite_product_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProductRepository {
  static Database? _database;
  static const int _version = 1;
  static const String _tableName = 'favorite';

  Future<void> initDb() async {
    if (_database != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}/favorite.db';
      _database = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $_tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT, product_id STRING, name STRING, price INTEGER, price_after_discount INTEGER, images STRING)',
          );
        },
      );
    } catch (_) {}
  }

  Future<int> insert(FavoriteProductModel? product) async {
    return await _database?.insert(_tableName, product!.toJson()) ?? 1;
  }

  Future<List<Map<String, dynamic>>> query() async {
    return await _database?.query(_tableName) ?? [];
  }

  delete(FavoriteProductModel product) async {
    return await _database!.delete(
      _tableName,
      where: 'product_id=?',
      whereArgs: [product.productId],
    );
  }
}
