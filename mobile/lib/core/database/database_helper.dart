import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static const String databaseName = 'shop_assistant_ai.db';
  static const int databaseVersion = 2;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);

    return openDatabase(
      path,
      version: databaseVersion,

      // تفعيل Foreign Keys
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },

      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // ==========================================================
    // PRODUCTS
    // ==========================================================

    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        barcode TEXT NOT NULL UNIQUE,
        purchase_price REAL NOT NULL,
        selling_price REAL NOT NULL,
        quantity INTEGER NOT NULL DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_products_name
      ON products(name);
    ''');

    await db.execute('''
      CREATE INDEX idx_products_barcode
      ON products(barcode);
    ''');

    // ==========================================================
    // SALES
    // ==========================================================

    await db.execute('''
      CREATE TABLE sales(
        id TEXT PRIMARY KEY,
        total REAL NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_sales_created_at
      ON sales(created_at);
    ''');

    // ==========================================================
    // SALE ITEMS
    // ==========================================================

    await db.execute('''
      CREATE TABLE sale_items(
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        subtotal REAL NOT NULL,

        FOREIGN KEY(sale_id)
          REFERENCES sales(id)
          ON DELETE CASCADE,

        FOREIGN KEY(product_id)
          REFERENCES products(id)
          ON UPDATE CASCADE
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_sale_items_sale
      ON sale_items(sale_id);
    ''');

    await db.execute('''
      CREATE INDEX idx_sale_items_product
      ON sale_items(product_id);
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
        );
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

          FOREIGN KEY(sale_id)
            REFERENCES sales(id)
            ON DELETE CASCADE,

          FOREIGN KEY(product_id)
            REFERENCES products(id)
            ON UPDATE CASCADE
        );
      ''');

      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode);',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_sales_created_at ON sales(created_at);',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_sale_items_sale ON sale_items(sale_id);',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_sale_items_product ON sale_items(product_id);',
      );
    }
  }

  Future<void> deleteDatabaseFile() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);

    await closeDatabase();

    await databaseFactory.deleteDatabase(path);
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}