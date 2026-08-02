import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/supplier_model.dart';

class SupplierLocalDataSource {
  Future<Database> get _db async =>
      DatabaseHelper.instance.database;

  Future<List<SupplierModel>> getSuppliers() async {
    final db = await _db;

    final result = await db.query(
      'suppliers',
      orderBy: 'name ASC',
    );

    return result
        .map((e) => SupplierModel.fromMap(e))
        .toList();
  }

  Future<void> addSupplier(
    SupplierModel supplier,
  ) async {
    final db = await _db;

    await db.insert(
      'suppliers',
      supplier.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSupplier(
    SupplierModel supplier,
  ) async {
    final db = await _db;

    await db.update(
      'suppliers',
      supplier.toMap(),
      where: 'id=?',
      whereArgs: [supplier.id],
    );
  }

  Future<void> deleteSupplier(
    String id,
  ) async {
    final db = await _db;

    await db.delete(
      'suppliers',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}