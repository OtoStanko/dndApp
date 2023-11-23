enum Dice { d0, d4, d6, d8, d10, d12, d20, d100 }

int sides(Dice dice) {
  switch (dice) {
    case Dice.d4:
      return 4;
    case Dice.d6:
      return 6;
    case Dice.d8:
      return 8;
    case Dice.d10:
      return 10;
    case Dice.d12:
      return 12;
    case Dice.d20:
      return 20;
    case Dice.d100:
      return 100;
    default:
      return 0;
  }
}

String diceToString(Dice dice) {
  return 'd${sides(dice)}';
}

Dice getDiceBySide(int side) {
  switch (side) {
    case 4:
      return Dice.d4;
    case 6:
      return Dice.d6;
    case 8:
      return Dice.d8;
    case 10:
      return Dice.d10;
    case 12:
      return Dice.d12;
    case 20:
      return Dice.d20;
    case 100:
      return Dice.d100;
    default:
      return Dice.d0;
  }
}
