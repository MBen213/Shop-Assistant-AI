import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/sale_model.dart';

class SaleLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<List<SaleModel>> getSales() async {
    final db = await _db;

    final result = await db.query(
      'sales',
      orderBy: 'created_at DESC',
    );

    return result
        .map(
          (e) => SaleModel.fromMap(
            e,
            const [],
          ),
        )
        .toList();
  }

  Future<void> addSale(SaleModel sale) async {
    final db = await _db;

    await db.insert(
      'sales',
      sale.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteSale(String id) async {
    final db = await _db;

    await db.delete(
      'sales',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}