import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/customer_model.dart';

class CustomerLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  // ==========================
  // Get All Customers
  // ==========================

  Future<List<CustomerModel>> getCustomers() async {
    final db = await _db;

    try {
      final result = await db.query(
        'customers',
        orderBy: 'name ASC',
      );

      return result
          .map((e) => CustomerModel.fromMap(e))
          .toList();
    } catch (e) {
      debugPrint('getCustomers() Error: $e');
      rethrow;
    }
  }

  // ==========================
  // Add Customer
  // ==========================

  Future<void> addCustomer(CustomerModel customer) async {
    final db = await _db;

    try {
      await db.insert(
        'customers',
        customer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      debugPrint('Customer Added Successfully');
    } catch (e) {
      debugPrint('addCustomer() Error: $e');
      rethrow;
    }
  }

  // ==========================
  // Update Customer
  // ==========================

  Future<void> updateCustomer(CustomerModel customer) async {
    final db = await _db;

    try {
      await db.update(
        'customers',
        customer.toMap(),
        where: 'id = ?',
        whereArgs: [customer.id],
      );

      debugPrint('Customer Updated Successfully');
    } catch (e) {
      debugPrint('updateCustomer() Error: $e');
      rethrow;
    }
  }

  // ==========================
  // Delete Customer
  // ==========================

  Future<void> deleteCustomer(String id) async {
    final db = await _db;

    try {
      await db.delete(
        'customers',
        where: 'id = ?',
        whereArgs: [id],
      );

      debugPrint('Customer Deleted Successfully');
    } catch (e) {
      debugPrint('deleteCustomer() Error: $e');
      rethrow;
    }
  }
}