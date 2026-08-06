import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'migrations/migration_v2.dart';
import 'migrations/migration_v3.dart';
import 'migrations/migration_v4.dart';
import 'migrations/migration_v5.dart';
import 'migrations/migration_v6.dart';
import 'migrations/migration_v7.dart';
import 'migrations/migration_v8.dart';

import 'tables/products_table.dart';
import 'tables/customers_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/sales_table.dart';
import 'tables/sale_items_table.dart';
import 'tables/purchases_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/users_table.dart';
import 'tables/settings_table.dart';
import 'tables/expenses_table.dart';

import 'indexes.dart';
import 'triggers.dart';
import 'views.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
   final dbPath = await getDatabasesPath();

   final path = join(
     dbPath,
     'shop_assistant_ai.db',
    );

    return openDatabase(
      path,
      version: 8,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onConfigure(Database db) async {
   await db.execute(
     'PRAGMA foreign_keys = ON;',
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async
  {

    await db.execute(ProductsTable.createTable);

    await db.execute(CustomersTable.createTable);

    await db.execute(SuppliersTable.createTable);

    await db.execute(SalesTable.createTable);

    await db.execute(SaleItemsTable.createTable);

    await db.execute(PurchasesTable.createTable);

    await db.execute(PurchaseItemsTable.createTable);

    await db.execute(UsersTable.createTable);

    await db.execute(SettingsTable.createTable);

    await db.execute(ExpensesTable.createTable);

    await DatabaseIndexes.create(db);

    await DatabaseViews.create(db);

    await DatabaseTriggers.create(db);
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async
  {

   if (oldVersion < 2) {
     await MigrationV2.run(db);
    }

    if (oldVersion < 3) {
      await MigrationV3.run(db);
    }

    if (oldVersion < 4) {
      await MigrationV4.run(db);
    }

    if (oldVersion < 5) {
      await MigrationV5.run(db);
    }

    if (oldVersion < 6) {
      await MigrationV6.run(db);
    }

    if (oldVersion < 7) {
      await MigrationV7.run(db);
    }

    if (oldVersion < 8) {
      await MigrationV8.run(db);
    }
  }
