import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'SessionObject.dart';

class PaLaCasaDB {
  static final PaLaCasaDB instance = PaLaCasaDB._init();

  static Database? _database;

  PaLaCasaDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('palacasa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB,onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final usuarioType = 'TEXT NOT NULL';
    final cookieType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableSesion (
    ${SessionObjectFields.id} $idType,
    ${SessionObjectFields.token} $usuarioType,
    ${SessionObjectFields.email} $cookieType,
    ${SessionObjectFields.name} $cookieType,
    ${SessionObjectFields.lastname} $cookieType,
    ${SessionObjectFields.phone} $cookieType,
    ${SessionObjectFields.photo} $cookieType,
    ${SessionObjectFields.id_role} $cookieType,
    ${SessionObjectFields.birthday} $cookieType,
    ${SessionObjectFields.gender} $cookieType
    );
    ''');



  }
  // UPGRADE DATABASE TABLES
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try{

      if (oldVersion < newVersion) {
        // you can execute drop table and create table

      }
    }catch(a){
      print(a);
    }

  }


  Future<SessionObject> createSession(SessionObject session) async {
    final db = await instance.database;
    final id = await db.insert(tableSesion, session.toJson());
    return session.copy(id: id);
  }

  Future<List<SessionObject>> readAllSesion() async {
    final db = await instance.database;
    final result = await db.query(tableSesion);
    return result.map((json) => SessionObject.fromJson(json)).toList();
  }

  Future<SessionObject> readSesion(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSesion,
      columns: SessionObjectFields.values,
      where: '${SessionObjectFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SessionObject.fromJson(maps.first);
    } else {
      print('ID $id not found');
      SessionObject ss = new SessionObject(id: 0, name: 'name', lastname: 'lastname', email: 'email', phone: 'phone', photo: 'photo', id_role: 'id_role', birthday: 'birthday', gender: 'gender', token: 'token');
      return ss;
    }
  }

  Future<int> updateSession(SessionObject session) async {
    final db = await instance.database;
    return db.update(
      tableSesion,
      session.toJson(),
      where: '${SessionObjectFields.id} = ?',
      whereArgs: [session.id],
    );
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}