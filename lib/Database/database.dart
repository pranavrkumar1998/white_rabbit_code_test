import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeDirectoryDatabase {
  static final EmployeeDirectoryDatabase _instance =
      EmployeeDirectoryDatabase._();
  static Database _database;

  EmployeeDirectoryDatabase._();

  factory EmployeeDirectoryDatabase() {
    return _instance;
  }

  static Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  static Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  static void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE employeeCommonDetails(
        id INTEGER,
        name TEXT,
        username TEXT,
        email TEXT,
        profile_image TEXT,
        street TEXT,
        suite TEXT,
        city TEXT,
        zipcode TEXT,
        lat TEXT,
        lng TEXT,
        phone TEXT,
        website TEXT,
        companyName TEXT,
        companyCatchPhrase TEXT,
        companyBS TEXT)
    ''');
    print("database was created");
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }

  Future<void> removeAll() async {
    var client = await db;
    client.rawDelete("DELETE FROM employeeCommonDetails");
  }

  Future<void> remove(String table) async {
    var client = await db;
    client.rawDelete("DELETE FROM $table");
  }
}
