import 'package:firstapp/classes/character.dart';
import 'package:firstapp/db/models/class_model.dart';

const double dividerWidth = 20;

// SQLITE
const sqliteDBName = "database";
const sqliteCharactersTableName = "characters";
const sqliteCharacterClassTableName = "classes";

const levelInputError = "Input a level in range of 1 to 20";
const nameInputError = "Please insert a valid name";

const creatingCharacterSnackbar = "Creating your character, please wait...";

// Helpers
var defaultClass = Class(className: "", id: -1, classDescription: "");
var emptyCharacter = Character(
    id: -1, characterName: "", characterClass: defaultClass, characterLevel: 0);
