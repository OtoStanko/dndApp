import 'dart:async';

import 'package:firstapp/classes/character.dart' as classes;
import 'package:firstapp/classes/classes.dart';
import 'package:firstapp/db/init/init_database.dart';
import 'package:firstapp/db/models/character_model.dart';
import 'package:firstapp/db/models/class_model.dart';
import 'package:firstapp/static/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sq;

class Database {
  late Future<sq.Database> _database;

  Database() {
    WidgetsFlutterBinding.ensureInitialized();
    database = initDB();
  }

  Future<sq.Database> initDB() async {
    return sq.openDatabase(
      join(await sq.getDatabasesPath(), "$sqliteDBName.db"),
      onCreate: (db, version) {
        initDatabase(db);
        // return _initCharacters();
      },
      version: 1,
    );
  }

  void _initCharacters() async {
    const int number = 20;
    for (var i = 0; i < number; i++) {
      Character character = Character(
          id: -1,
          iconPath: "images/bear.jpg",
          characterName: "Bear-${i}",
          characterClass: Classes().getClass("Fighter"));
      insertCharacter(character);
    }
  }

  Future<sq.Database> get database async {
    return await _database;
  }

  set database(Future<sq.Database> db) {
    _database = db;
  }

  Future<void> insertCharacter(Character character) async {
    final db = await database;

    // Allow Auto-incrementing the ID
    Map<String, dynamic> map = character.toMap();
    map.remove("id");

    int id = await db.insert(
      sqliteCharactersTableName,
      map,
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );

    character.id = id;
  }

  Future<List<Character>> characters() async {
    final db = await database;
    final classes = await Classes().getClasses();

    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharactersTableName,
        columns: ["id", "iconPath", "characterName", "characterClass"]);

    var items = List.generate(maps.length, (i) {
      var c = classes["${maps[i]['characterClass']}"] ??
          Class(id: -1, className: "Default", classDescription: "Default");
      return Character(
          id: maps[i]['id'],
          characterName: maps[i]['characterName'],
          iconPath: maps[i]['iconPath'],
          characterClass: c);
    });
    return items;
  }

  Future<List<Class>> characterClasses() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharacterClassTableName,
        columns: ["id", "className", "classDescription"]);

    var items = List.generate(maps.length, (i) {
      return Class(
        id: maps[i]['id'],
        className: maps[i]['className'],
        classDescription: maps[i]['classDescription'],
      );
    });
    return items;
  }

  Future<classes.Character> getCharacter(int id) async {
    final db = await database;
    final cl = await Classes().getClasses();

    final List<Map<String, dynamic>> map = await db
        .query(sqliteCharactersTableName, where: 'id = ?', whereArgs: [id]);

    var c = cl["${map[0]['characterClass']}"] ??
        Class(id: -1, className: "Default", classDescription: "Default");

    return classes.Character(
      id: map[0]['id'],
      characterName: map[0]['characterName'],
      iconPath: map[0]['iconPath'],
      characterClass: c,
      characterLevel: map[0]['characterLevel'],
    );
  }

  Future<void> updateCharacter(Character character) async {
    final db = await database;

    await db.update(
      sqliteCharactersTableName,
      character.toMap(),
      where: 'id = ?',
      whereArgs: [character.id],
    );
  }

  Future<void> deleteCharacter(int id) async {
    final db = await database;

    await db.delete(
      sqliteCharactersTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
