import 'package:firstapp/static/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

// key in init.sql file : value which should be replaced with
var pairs = <dynamic, dynamic>{
  "charactersTable": sqliteCharactersTableName,
  "classesTable": sqliteCharacterClassTableName,
  "featuresTable": sqliteCharacterFeaturesTableName,
  "featureConnectionsTable": sqliteCharacterFeatureConnectionsTableName,
};

void initDatabase(Database database) async {
  String f;
  if (kDebugMode) {
    f = await rootBundle.loadString('lib/db/init/init.sql');
  }else {
    f = await rootBundle.loadString('lib/db/init/init-release.sql');
  }

  var strings = f.split(";").map((e) => e.trim());

  for (var inputString in strings) {
    if (inputString.isEmpty) continue;
    for (var key in pairs.keys) {
      RegExp regex = RegExp("[$key]");
      if (!regex.hasMatch(inputString)) continue;
      inputString = inputString.replaceAll("[$key]", pairs[key]);
    }
    database.execute(inputString);
  }
}
