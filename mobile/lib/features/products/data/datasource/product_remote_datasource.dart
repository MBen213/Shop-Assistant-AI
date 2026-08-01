import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<List<ProductModel>> getProducts() async {
    final db = await _db;

    final result = await db.query(
      'products',
      orderBy: 'name ASC',
    );

    return result.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    final db = await _db;

    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await _db;

    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(String id) async {
    final db = await _db;

    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}