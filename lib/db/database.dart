import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firstapp/api/api_connector.dart';
import 'package:firstapp/classes/character.dart' as classes;
import 'package:firstapp/classes/classes.dart';
import 'package:firstapp/db/init/init_database.dart';
import 'package:firstapp/db/models/character_model.dart';
import 'package:firstapp/db/models/class_model.dart';
import 'package:firstapp/db/models/feature_model.dart';
import 'package:firstapp/static/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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
          Class(
              id: -1,
              className: "Default",
              classDescription: "Default",
              classHitDie: 0);
      return Character(
          id: maps[i]['id'],
          characterName: maps[i]['characterName'],
          image: maps[i]['image'],
          characterClass: c);
    });
    return items;
  }

  Future<bool> checkIfClassIsUsed(Class c) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharactersTableName,
        columns: ["id", "image", "characterName", "characterClass"],
        where: "characterClass = ?",
        whereArgs: [c.id]);

    return maps.isNotEmpty;
  }

  Future<bool> deleteClass(Class c) async {
    final db = await database;

    // Remove class only if it is not used by a character
    int numOfChangedLines = await db.delete(sqliteCharacterClassTableName,
        where:
            "id = ? AND id NOT IN (SELECT characterClass FROM $sqliteCharactersTableName)",
        whereArgs: [c.id]);

    return numOfChangedLines > 0;
  }

  Future<void> deleteAllClasses() async {
    final db = await database;
    // Remove all classes that ar not in the characterfeatures table
    await db.delete(sqliteCharacterClassTableName,
        where:
            "id NOT IN (SELECT characterId FROM $sqliteCharacterFeatureConnectionsTableName)");
  }

  Future<Class> getClassById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharacterClassTableName,
        columns: ["id", "className", "classDescription", "classHitDie"],
        where: "id = ?",
        whereArgs: [id]);
    return Class(
        id: maps[0]['id'],
        className: maps[0]['className'],
        classDescription: maps[0]['classDescription'],
        classHitDie: maps[0]['classHitDie']);
  }

  Future<List<Class>> getAllClasses() async {
    return await characterClasses();
  }

  Future<List<Class>> characterClasses() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
        sqliteCharacterClassTableName,
        columns: ["id", "className", "classDescription", "classHitDie"]);

    var items = List.generate(maps.length, (i) {
      return Class(
          id: maps[i]['id'],
          className: maps[i]['className'],
          classDescription: maps[i]['classDescription'],
          classHitDie: maps[i]['classHitDie']);
    });
    return items;
  }

  Future<void> insertClass(Class characterClass) async {
    final db = await database;

    // Allow Auto-incrementing the ID
    Map<String, dynamic> map = characterClass.toMap();
    map.remove("id");

    await db.insert(
      sqliteCharacterClassTableName,
      map,
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );
  }

  Future<classes.Character> getCharacter(int id) async {
    final db = await database;
    final cl = await Classes().getClasses();

    final List<Map<String, dynamic>> map = await db
        .query(sqliteCharactersTableName, where: 'id = ?', whereArgs: [id]);

    var c = cl[map[0]['characterClass']] ??
        Class(
            id: -1,
            className: "Default",
            classDescription: "Default",
            classHitDie: 0);

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
    Map<String, dynamic> map = {
      "featureName": feature.featureName,
      "featureDescription": feature.featureDescription,
      "featureType": 'feature',
      "featureLevelAcquire": feature.featureLevelAcquire,
      "featurePrimaryClass": feature.featurePrimaryClass,
    };
    map.remove("id");

    int id = await db.insert(
      sqliteCharacterFeaturesTableName,
      map,
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );

    feature.id = id;
    return feature;
  }

  Future<List<Feature>> getFeaturesForCharacter(Character character) async {
    return await features(character);
  }

  Future<List<Feature>> features(Character character) async {
    final db = await database;

    final selectString =
        "SELECT $sqliteCharacterFeatureConnectionsTableName.id, featureName, featureDescription, featureLevelAcquire, featurePrimaryClass, featureMaxLevel, featureUsed FROM $sqliteCharacterFeatureConnectionsTableName INNER JOIN $sqliteCharacterFeaturesTableName ON $sqliteCharacterFeaturesTableName.id = $sqliteCharacterFeatureConnectionsTableName.featureId WHERE $sqliteCharacterFeatureConnectionsTableName.characterId = ${character.id};";

    final List<Map<String, dynamic>> maps = await db.rawQuery(selectString);

    var items = List.generate(maps.length, (i) {
      return Feature(
          id: maps[i]['id'],
          featureName: maps[i]['featureName'],
          featureDescription: maps[i]['featureDescription'],
          featureLevelAcquire: maps[i]['featureLevelAcquire'],
          featurePrimaryClass: maps[i]['featurePrimaryClass'],
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
        "featureMaxLevel": feature.featureMaxLevel,
        "featureUsed": feature.featureUsed,
      },
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );
  }

  Future<void> unassignFeature(Feature feature, Character character) async {
    final db = await database;

    await db.delete(
      sqliteCharacterFeatureConnectionsTableName,
      where: 'id = ?',
      whereArgs: [feature.id],
    );
  }

  Future<List<Feature>> getAllFeatures() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(sqliteCharacterFeaturesTableName, columns: [
      "id",
      "featureName",
      "featureDescription",
      "featureLevelAcquire",
      "featurePrimaryClass"
    ]);

    var items = List.generate(maps.length, (i) {
      return Feature(
          id: maps[i]['id'],
          featureName: maps[i]['featureName'],
          featureDescription: maps[i]['featureDescription'],
          featureLevelAcquire: maps[i]['featureLevelAcquire'],
          featurePrimaryClass: maps[i]['featurePrimaryClass'],
          featureMaxLevel: -1, // Should be set by the user
          featureUsed: -1 // Should be set by the user
          );
    });
    return items;
  }

  Future<void> updateFeatureForCharacter(
      Feature feature, Character character) async {
    final db = await database;

    await db.update(
      sqliteCharacterFeatureConnectionsTableName,
      {
        "featureMaxLevel": feature.featureMaxLevel,
        "featureUsed": feature.featureUsed,
      },
      where: 'id = ? AND characterId = ?',
      whereArgs: [feature.id, character.id],
    );
  }

  Future<void> deleteFeatureFromCharacter(Feature feature) async {
    final db = await database;

    await db.delete(
      sqliteCharacterFeaturesTableName,
      where: 'id = ?',
      whereArgs: [feature.id],
    );
  }

  Future<void> createCustomFeature(Feature feature) async {
    final db = await database;

    await db.insert(
      sqliteCharacterFeaturesTableName,
      {
        "featureName": feature.featureName,
        "featureDescription": feature.featureDescription,
        "featureType": "user-created",
        "featureLevelAcquire": feature.featureLevelAcquire,
        "featurePrimaryClass": feature.featurePrimaryClass,
      },
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );
  }

  // API stuff
  Future<void> updateFeatureTable() async {
    // Get data from API
    final api = ApiConnector();
    final features = await api.getFeatures();
    // Remove all features from database
    await deleteAllFeatures();

    // Insert into database
    for (var f in features) {
      await insertFeature(f);
    }
  }

  Future<void> updateClassTable() async {
    // Get data from API
    final api = ApiConnector();
    final classes = await api.getClasses();

    // Remove all classes from database
    await deleteAllClasses();

    // Insert into database
    for (var c in classes) {
      await insertClass(c);
    }
  }

  Future<void> deleteAllFeatures() async {
    final db = await database;
    // Remove all features that ar not in the characterfeatures table
    await db.delete(sqliteCharacterFeaturesTableName,
        where:
            "id NOT IN (SELECT featureId FROM $sqliteCharacterFeatureConnectionsTableName)");
  }

  Future<bool> deleteFeature(Feature feature) async {
    final db = await database;

    // Remove feature from feature table only if it is not in the characterfeatures table
    int changed = await db.delete(sqliteCharacterFeaturesTableName,
        where:
            "id = ? AND id NOT IN (SELECT featureId FROM $sqliteCharacterFeatureConnectionsTableName)",
        whereArgs: [feature.id]);

    return changed > 0;
  }

  Future<Map<String, List<dynamic>>> dumpDatabase() async {
    final db = await database;

    // Get all classes
    final List<Map<String, dynamic>> classMaps = await db.query(
        sqliteCharacterClassTableName,
        columns: ["className", "classDescription", "classHitDie"]);

    // Get all features
    final List<Map<String, dynamic>> featureMaps =
        await db.query(sqliteCharacterFeaturesTableName, columns: [
      "featureName",
      "featureDescription",
      'featureType',
      "featureLevelAcquire",
      "featurePrimaryClass"
    ]);

    // Get all characters
    final List<Map<String, dynamic>> characterMaps =
        await db.query(sqliteCharactersTableName, columns: [
      "characterName",
      "characterClass",
      "characterLevel",
      "image",
    ]);

    // Get all feature connections
    final List<Map<String, dynamic>> featureConnectionMaps = await db
        .query(sqliteCharacterFeatureConnectionsTableName, columns: [
      "characterId",
      "featureId",
      "featureMaxLevel",
      "featureUsed"
    ]);

    return {
      "classes": classMaps,
      "features": featureMaps,
      "characters": characterMaps,
      "featureConnections": featureConnectionMaps,
    };
  }

  Future<String> dumpDatabaseToJSON() async {
    final db = await database;

    // Get data
    final data = await dumpDatabase();

    // Convert to JSON
    final json = jsonEncode(data);
    return json;
  }

  Future<bool> loadDatabaseFromJSON(String json) async {
    // Parse JSON
    final data = jsonDecode(json);

    // Get all classes
    final classes = data["classes"] as List<dynamic>;

    // Get all features
    final features = data["features"] as List<dynamic>;

    // Get all characters
    final characters = data["characters"] as List<dynamic>;

    // Get all feature connections
    final featureConnections = data["featureConnections"] as List<dynamic>;

    // Update database in transaction
    final db = await database;

    db.transaction((txn) async {
      // Delete data in tables
      await txn.delete(sqliteCharacterClassTableName);
      await txn.delete(sqliteCharacterFeaturesTableName);
      await txn.delete(sqliteCharactersTableName);
      await txn.delete(sqliteCharacterFeatureConnectionsTableName);

      // Insert classes
      for (var c in classes) {
        await txn.insert(sqliteCharacterClassTableName, {
          "className": c["className"],
          "classDescription": c["classDescription"],
          "classHitDie": c["classHitDie"],
        });
      }

      // Insert features
      for (var f in features) {
        await txn.insert(sqliteCharacterFeaturesTableName, {
          "featureName": f["featureName"],
          "featureDescription": f["featureDescription"],
          "featureType": f["featureType"],
          "featureLevelAcquire": f["featureLevelAcquire"],
          "featurePrimaryClass": f["featurePrimaryClass"],
        });
      }

      // Insert characters
      for (var c in characters) {
        await txn.insert(sqliteCharactersTableName, {
          "characterName": c["characterName"],
          "characterClass": c["characterClass"],
          "characterLevel": c["characterLevel"],
          "image": Uint8List.fromList([]),
          //"image": Uint8List(c["image"]),
        });
      }

      // Insert feature connections
      for (var f in featureConnections) {
        await txn.insert(sqliteCharacterFeatureConnectionsTableName, {
          "characterId": f["characterId"],
          "featureId": f["featureId"],
          "featureMaxLevel": f["featureMaxLevel"],
          "featureUsed": f["featureUsed"],
        });
      }

      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
    return true;
  }

  Future<void> featureAppend(String jsonFeatures) async {
    final db = await database;

    // Parse JSON
    final data = jsonDecode(jsonFeatures);

    // Get all features
    final features = data["features"] as List<dynamic>;

    // Insert features transactionally
    db.transaction((txn) async {
      // Insert features
      for (var f in features) {
        await txn.insert(sqliteCharacterFeaturesTableName, {
          "featureName": f["featureName"],
          "featureDescription": f["featureDescription"],
          "featureType": f["featureType"] ?? "json-created",
          "featureLevelAcquire": f["featureLevelAcquire"] ?? "1",
          "featurePrimaryClass": f["featurePrimaryClass"] ?? "None",
        });
      }
    });
  }
}
