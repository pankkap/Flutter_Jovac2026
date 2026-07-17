import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './model/student.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("student.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE students(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      course TEXT,
      age INTEGER
    )
    ''');
  }

  // Insert

  Future<int> insertStudent(Student student) async {
    final db = await instance.database;

    return await db.insert(
      "students",
      student.toMap(),
    );
  }

  // Read

  Future<List<Student>> getStudents() async {
    final db = await instance.database;

    final result = await db.query("students");

    return result.map((e) => Student.fromMap(e)).toList();
  }

  // Update

  Future<int> updateStudent(Student student) async {
    final db = await instance.database;

    return await db.update(
      "students",
      student.toMap(),
      where: "id=?",
      whereArgs: [student.id],
    );
  }

  // Delete

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;

    return await db.delete(
      "students",
      where: "id=?",
      whereArgs: [id],
    );
  }
}