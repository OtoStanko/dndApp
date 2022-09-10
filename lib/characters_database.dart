// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import "character.dart";
//import 'package:sqflite_database_example/model/note.dart';


class CharacterDatabase {
  static final CharacterDatabase instance = CharacterDatabase._init();

  static Database? _database;

  CharacterDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('characters.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const nameType = "STRING NOT NULL";
    const classType = "INTEGER NOT NULL";
    const lvlType = "INTEGER NOT NULL";
    await db.execute("""CREATE TABLE $tableCharacters (
      ${CharacterFields.id} $idType,
      ${CharacterFields.charName} $nameType,
      ${CharacterFields.charClass} $classType,
      ${CharacterFields.charLvl} $lvlType
    )""");
  }

  Future<Character> create(Character character) async {
    final db = await instance.database;
    final id = await db.insert(tableCharacters, character.toJson());
    return character.copy(id: id);
  }

  Future<Character> readCharacter(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCharacters,
      columns: CharacterFields.values,
      where: '${CharacterFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Character.fromJson(maps.first);
    }
    throw Exception("ID $id not found");
  }

  Future<List<Character>> readAllCharacters() async {
    final db = await instance.database;
    final result = await db.query(tableCharacters, orderBy: "${CharacterFields.id} ASC");
    return result.map((json) => Character.fromJson(json)).toList();
  }

  Future<int> update(Character character) async {
    final db = await instance.database;
    return db.update(
      tableCharacters,
      character.toJson(),
      where: "${CharacterFields.id} = ?",
      whereArgs: [character.id],
      );
  }

  Future delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableCharacters,
      where: "${CharacterFields.id} = ?",
      whereArgs: [id],
      );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}