import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'shop_assistant_ai.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // ==========================
    // PRODUCTS
    // ==========================

    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        barcode TEXT NOT NULL,
        purchase_price REAL NOT NULL,
        selling_price REAL NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');

    // ==========================
    // SALES
    // ==========================

    await db.execute('''
      CREATE TABLE sales(
        id TEXT PRIMARY KEY,
        total REAL NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // ==========================
    // SALE ITEMS
    // ==========================

    await db.execute('''
      CREATE TABLE sale_items(
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        subtotal REAL NOT NULL,
        FOREIGN KEY(sale_id) REFERENCES sales(id),
        FOREIGN KEY(product_id) REFERENCES products(id)
      )
    ''');
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS sales(
          id TEXT PRIMARY KEY,
          total REAL NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS sale_items(
          id TEXT PRIMARY KEY,
          sale_id TEXT NOT NULL,
          product_id TEXT NOT NULL,
          product_name TEXT NOT NULL,
          price REAL NOT NULL,
          quantity INTEGER NOT NULL,
          subtotal REAL NOT NULL,
          FOREIGN KEY(sale_id) REFERENCES sales(id),
          FOREIGN KEY(product_id) REFERENCES products(id)
        )
      ''');
    }
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}