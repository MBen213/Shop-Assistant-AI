import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'indexes.dart';
import 'triggers.dart';
import 'views.dart';

import 'migrations/migration_v2.dart';
import 'migrations/migration_v3.dart';
import 'migrations/migration_v4.dart';
import 'migrations/migration_v5.dart';
import 'migrations/migration_v6.dart';
import 'migrations/migration_v7.dart';
import 'migrations/migration_v8.dart';
import 'migrations/migration_v9.dart';

import 'tables/customers_table.dart';
import 'tables/expenses_table.dart';
import 'tables/products_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/purchases_table.dart';
import 'tables/sale_items_table.dart';
import 'tables/sales_table.dart';
import 'tables/settings_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/users_table.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static const String databaseName = 'shop_assistant_ai.db';
  static const int databaseVersion = 9;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();

    final path = join(
      databasesPath,
      databaseName,
    );

    return openDatabase(
      path,
      version: databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute(
      'PRAGMA foreign_keys = ON;',
    );
  }

  Future<void> _onOpen(Database db) async {
    // Reserved for future initialization.
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.transaction((txn) async {
      await txn.execute(ProductsTable.createTable);

      await txn.execute(CustomersTable.createTable);

      await txn.execute(SuppliersTable.createTable);

      await txn.execute(SalesTable.createTable);

      await txn.execute(SaleItemsTable.createTable);

      await txn.execute(PurchasesTable.createTable);

      await txn.execute(PurchaseItemsTable.createTable);

      await txn.execute(UsersTable.createTable);

      await txn.execute(SettingsTable.createTable);

      await txn.execute(ExpensesTable.createTable);

      await DatabaseIndexes.create(txn);

      await DatabaseViews.create(txn);

      await DatabaseTriggers.create(txn);
    });
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await db.transaction((txn) async {
      if (oldVersion < 2) {
        await MigrationV2.run(txn);
      }

      if (oldVersion < 3) {
        await MigrationV3.run(txn);
      }

      if (oldVersion < 4) {
        await MigrationV4.run(txn);
      }

      if (oldVersion < 5) {
        await MigrationV5.run(txn);
      }

      if (oldVersion < 6) {
        await MigrationV6.run(txn);
      }

      if (oldVersion < 7) {
        await MigrationV7.run(txn);
      }

      if (oldVersion < 8) {
        await MigrationV8.run(txn);
      }
      if (oldVersion < 9) {
        await MigrationV9.run(txn);
      }
    });
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> delete() async {
    await close();

    final databasesPath = await getDatabasesPath();

    final path = join(
      databasesPath,
      databaseName,
    );

    await deleteDatabase(path);
  }

  // =====================================================
  // DASHBOARD
  // =====================================================

  Future<int> getProductsCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM ${ProductsTable.tableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0; 
  }

  Future<int> getCustomersCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM ${CustomersTable.tableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getSuppliersCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM ${SuppliersTable.tableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getSalesCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM ${SalesTable.tableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<double> getRevenue() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT SUM(total) FROM ${SalesTable.tableName}',
    );

    final value = result.first.values.first;

    if (value == null) return 0;

    return (value as num).toDouble(); 
  }

  Future<int> getLowStockProductsCount() async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${ProductsTable.tableName}
      WHERE quantity<=5
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTodaySalesCount() async {
    final db = await database;

    final today =
    DateTime.now().toIso8601String().substring(0, 10);

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${SalesTable.tableName}
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<double> getTodayRevenue() async {
    final db = await database;

    final today =
    DateTime.now().toIso8601String().substring(0, 10);

    final result = await db.rawQuery(
      '''
      SELECT SUM(total)
      FROM ${SalesTable.tableName}
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    final value = result.first.values.first;

    if (value == null) return 0;

    return (value as num).toDouble();
  }

  Future<double> getTodayProfit() async {
    final db = await database;

    final today =
    DateTime.now().toIso8601String().substring(0, 10);

    final revenueResult = await db.rawQuery(
      '''
      SELECT SUM(total)
      FROM ${SalesTable.tableName}
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    final expenseResult = await db.rawQuery(
      '''
      SELECT SUM(amount)
      FROM ${ExpensesTable.tableName}
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    final revenue =
    (revenueResult.first.values.first as num?)?.toDouble() ?? 0;

   final expenses =
    (expenseResult.first.values.first as num?)?.toDouble() ?? 0;

    return revenue - expenses;
  }

  // =====================================================
  // PURCHASES
  // =====================================================

  Future<void> insertPurchase(
    dynamic purchase,
  ) async {
    final db = await database;

    await db.insert(
      PurchasesTable.tableName,
      purchase.toMap(),
    );

    final batch = db.batch();

    for (final item in purchase.items) {
      batch.insert(
        PurchaseItemsTable.tableName,
        item.toMap(),
      );

      batch.rawUpdate(
        '''
        UPDATE ${ProductsTable.tableName}
        SET quantity = quantity + ?
        WHERE id = ?
        ''',
        [
          item.quantity,
          item.productId,
        ],
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> deletePurchase(
    String id,
  ) async {
    final db = await database;

    await db.delete(
      PurchasesTable.tableName,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getPurchases() async {
    final db = await database;

    return db.query(
      PurchasesTable.tableName,
      orderBy: 'created_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getPurchaseItems(
    String purchaseId,
  ) async {
    final db = await database;

    return db.query(
      PurchaseItemsTable.tableName,
      where: 'purchase_id=?',
      whereArgs: [purchaseId],
    );
  }
}