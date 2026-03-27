import 'dart:io';

import 'package:flutter_application_1/models/CastDAO.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

class CastDb {
  static final nameDB = 'cast_db';
  static final versionDB = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = '${folder.path}/$nameDB.db';
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: createTables,
    );
  }

  createTables(database, version) {
    String query = '''
    CREATE TABLE cast(
      id_cast INTEGER PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      birth_date VARCHAR(10) NOT NULL,
      age INTEGER NOT NULL,
      gender CHAR(1) NOT NULL
      );
''';
    database.execute(query);
  }

  Future<int> insert(Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.insert('cast', data);
  }

  Future<int> update(Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.update(
      'cast',
      data,
      where: 'id_cast = ?',
      whereArgs: [data['id_cast']],
    );
  }

  Future<int> delete(int id_cast) async {
    var connection = await database;
    return connection!.delete(
      'cast',
      where: 'id_cast = ?',
      whereArgs: [id_cast],
    );
  }

  Future<List<CastDAO>> select() async {
    var connection = await database;
    var result = await connection!.query('cast');
    var list = result.map((cast) => CastDAO.fromMap(cast)).toList();
    return list;
  }
}
