import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'MapNotesDatabase.db';
  static const _databaseVersion = 1;
  static const notesTable = 'notesTable';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnLatitude = 'latitude';
  static const columnLongitude = 'longitude';
  static const columnDateTime = 'dateTime';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute(
      """
      CREATE TABLE $notesTable (
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT NOT NULL,
      $columnLatitude TEXT NOT NULL,
      $columnLongitude TEXT NOT NULL,
      $columnDateTime TEXT NOT NULL )
      """,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(notesTable);
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(notesTable, row);
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(notesTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> update(int id, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(notesTable, row, where: '$columnId = ?', whereArgs: [id]);
  }
}
