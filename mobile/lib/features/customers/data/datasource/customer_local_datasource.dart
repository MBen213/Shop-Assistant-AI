import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/customer_model.dart';

class CustomerLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<List<CustomerModel>> getCustomers() async {
    final db = await _db;

    final result = await db.query(
      'customers',
      orderBy: 'name ASC',
    );

    return result
        .map((e) => CustomerModel.fromMap(e))
        .toList();
  }

  Future<void> addCustomer(CustomerModel customer) async {
    final db = await _db;

    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    final db = await _db;

    await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteCustomer(String id) async {
    final db = await _db;

    await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}