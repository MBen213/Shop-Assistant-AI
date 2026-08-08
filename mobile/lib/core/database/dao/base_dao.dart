import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

abstract class BaseDao {
  Future<Database> get db async =>
      DatabaseHelper.instance.database;
}