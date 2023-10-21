import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:task_mobile/app/data/models/task_model.dart';

class TaskDatabaseHelper {
  static TaskDatabaseHelper? _taskDatabaseHelper;
  TaskDatabaseHelper._instance() {
    _taskDatabaseHelper = this;
  }

  factory TaskDatabaseHelper() =>
      _taskDatabaseHelper ?? TaskDatabaseHelper._instance();

  static Database? _database;

  FutureOr<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblTask = 'task';
  static const String _tblCache = 'cache';

  FutureOr<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/project.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTask (
        "id" INTEGER ,
        "name" TEXT,
        "description" TEXT,
        "quantity" INTEGER,
        "latitude" TEXT,
        "longitude" TEXT,
        "date" TEXT,
        "photo" TEXT,
        "address" TEXT,
        PRIMARY KEY ("id" AUTOINCREMENT)
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        quantity INTEGER,
        latitude TEXT,
        longitude TEXT,
        date TEXT,
        photo TEXT,
        address TEXT
      );
    ''');
  }


  FutureOr<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db!.rawInsert('''
    INSERT INTO $_tblTask (name, description, quantity, latitude, longitude, date, photo,address)
    VALUES (?, ?, ?, ?, ?, ?, ?,?)
  ''', [
      task.name,
      task.description,
      task.quantity,
      task.latitude,
      task.longitude,
      task.date,
      task.photo,
      task.address,
    ]);
  }


  FutureOr<Map<String, dynamic>?> gettaskById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTask,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  FutureOr<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTask);

    return results;
  }
}
