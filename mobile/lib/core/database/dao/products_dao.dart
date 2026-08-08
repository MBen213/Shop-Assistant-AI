import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../database_constants.dart';

class ProductsDao {
  ProductsDao._();

  static final ProductsDao instance = ProductsDao._();

  Future<Database> get _db async =>
      DatabaseHelper.instance.database;

  // ==========================
  // CREATE
  // ==========================

  Future insert(
    Map<String, dynamic> product,
  ) async {
    final db = await _db;

    return db.transaction((txn) async {
      await txn.insert(
        'products',
        product,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      final quantity =
          (product['quantity'] as num?)?.toInt() ?? 0;

      if (quantity > 0) {
        await txn.insert(
          'stock_movements',
          {
            'id': DateTime.now()
                .microsecondsSinceEpoch
                .toString(),
            'product_id': product['id'],
            'type': DatabaseConstants.stockMovementInitial,
            'quantity': quantity,
            'reference_id': null,
            'notes': 'Initial stock',
            'created_at': DateTime.now().toIso8601String(),
          },
        );
      }
    });
  }

  // ==========================
  // READ
  // ==========================

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _db;

    return db.query(
      'products',
      orderBy: 'name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(
    String id,
  ) async {
    final db = await _db;

    final result = await db.query(
      'products',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<Map<String, dynamic>?> getByBarcode(
    String barcode,
  ) async {
    final db = await _db;

    final result = await db.query(
      'products',
      where: 'barcode=?',
      whereArgs: [barcode],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<List<Map<String, dynamic>>> search(
    String keyword,
  ) async {
    final db = await _db;

    return db.query(
      'products',
      where: 'name LIKE ? OR barcode LIKE ?',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
      ],
      orderBy: 'name ASC',
    );
  }

  // ==========================
  // UPDATE
  // ==========================

  Future update(
    Map<String, dynamic> product,
  ) async {
    final db = await _db;

    return db.update(
      'products',
      product,
      where: 'id=?',
      whereArgs: [product['id']],
    );
  }

  Future updateQuantity(
    String productId,
    int quantity,
  ) async {
    final db = await _db;

    return db.update(
      'products',
      {
        'quantity': quantity,
      },
      where: 'id=?',
      whereArgs: [productId],
    );
  }

  // ==========================
  // DELETE
  // ==========================

  Future delete(
    String id,
  ) async {
    final db = await _db;

    return db.delete(
      'products',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // ==========================
  // STATISTICS
  // ==========================

  Future count() async {
    final db = await _db;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM products',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future lowStockCount() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM products
      WHERE quantity<=5
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}