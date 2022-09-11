import 'package:firstapp/enums/classes.dart';

class Character {
  late int id;
  late String charImgPath;
  late String charName;
  late Classes charClass;
  late int charLvl;

  Character(String imgPath, String name, Classes cls, int lvl) {
    charImgPath = imgPath;
    charName = name;
    charClass = cls;
    charLvl = lvl;
  }
}
