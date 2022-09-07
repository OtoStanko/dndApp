enum Classes {
  druid,
  fighter,
  barbarian,
}

class Character {
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