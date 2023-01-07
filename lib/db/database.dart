import 'dart:async';

import 'package:firstapp/classes/character.dart' as classes;
import 'package:firstapp/classes/classes.dart';
import 'package:firstapp/db/init/init_database.dart';
import 'package:firstapp/db/models/character_model.dart';
import 'package:firstapp/db/models/class_model.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:firstapp/static/constants.dart';
import 'package:firstapp/utils/utils.dart';
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

  @Deprecated("This is deprecated, all initailisation is done in init.sql")
  void _initCharacters() async {
    const int number = 20;
    for (var i = 0; i < number; i++) {
      Character character = Character(
          id: -1,
          characterName: "Bear-$i",
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

  Future<Character> insertCharacter(Character character) async {
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
    return character;
  }

  Future<List<Character>> characters() async {
    final db = await database;
    final classes = await Classes().getClasses();

    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharactersTableName,
        columns: ["id", "image", "characterName", "characterClass"]);

    var items = List.generate(maps.length, (i) {
      var c = classes[maps[i]['characterClass']] ??
          Class(id: -1, className: "Default", classDescription: "Default");
      return Character(
          id: maps[i]['id'],
          characterName: maps[i]['characterName'],
          image: maps[i]['image'],
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

    var c = cl[map[0]['characterClass']] ??
        Class(id: -1, className: "Default", classDescription: "Default");

    return classes.Character(
      id: map[0]['id'],
      characterName: map[0]['characterName'],
      image: map[0]['image'],
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

  Future<Feature> insertFeature(Feature feature) async {
    final db = await database;

    // Allow Auto-incrementing the ID
    Map<String, dynamic> map = feature.toMap();
    map.remove("id");

    int id = await db.insert(
      sqliteCharacterFeaturesTableName,
      map,
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );

    feature.id = id;
    return feature;
  }

  Future<List<Feature>> features(Character character) async {
    final db = await database;

    final selectString =
        "SELECT $sqliteCharacterFeatureConnectionsTableName.id, featureName, featureDescription, featureMaxLevel, featureUsed FROM $sqliteCharacterFeatureConnectionsTableName INNER JOIN $sqliteCharacterFeaturesTableName ON $sqliteCharacterFeaturesTableName.id = $sqliteCharacterFeatureConnectionsTableName.featureId WHERE $sqliteCharacterFeatureConnectionsTableName.characterId = ${character.id};";

    final List<Map<String, dynamic>> maps = await db.rawQuery(selectString);

    var items = List.generate(maps.length, (i) {
      return Feature(
          id: maps[i]['id'],
          featureName: maps[i]['featureName'],
          featureDescription: maps[i]['featureDescription'],
          featureMaxLevel: maps[i]['featureMaxLevel'],
          featureUsed: maps[i]['featureUsed']);
    });
    return items;
  }

  Future<void> assignFeature(Feature feature, Character character) async {
    final db = await database;

    await db.insert(
      sqliteCharacterFeatureConnectionsTableName,
      {
        "characterId": character.id,
        "featureId": feature.id,
      },
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );
  }
}
