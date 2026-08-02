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

    final path = join(
      databasePath,
      'shop_assistant_ai.db',
    );

    return openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    //---------------------------------------
    // PRODUCTS
    //---------------------------------------

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

    //---------------------------------------
    // SALES
    //---------------------------------------

    await db.execute('''
CREATE TABLE sales(
id TEXT PRIMARY KEY,
total REAL NOT NULL,
created_at TEXT NOT NULL
)
''');

    //---------------------------------------
    // SALE ITEMS
    //---------------------------------------

    await db.execute('''
CREATE TABLE sale_items(
id INTEGER PRIMARY KEY AUTOINCREMENT,
sale_id TEXT NOT NULL,
product_id TEXT NOT NULL,
product_name TEXT NOT NULL,
price REAL NOT NULL,
quantity INTEGER NOT NULL,
subtotal REAL NOT NULL
)
''');

    //---------------------------------------
    // CUSTOMERS
    //---------------------------------------

    await db.execute('''
CREATE TABLE customers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT,
created_at TEXT NOT NULL
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
id INTEGER PRIMARY KEY AUTOINCREMENT,
sale_id TEXT NOT NULL,
product_id TEXT NOT NULL,
product_name TEXT NOT NULL,
price REAL NOT NULL,
quantity INTEGER NOT NULL,
subtotal REAL NOT NULL
)
''');
    }

    if (oldVersion < 3) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS customers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT,
created_at TEXT NOT NULL
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