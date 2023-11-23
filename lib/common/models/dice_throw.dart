import 'package:firstapp/common/models/dice.dart';

class DiceThrow {
  final int count;
  final Dice dice;

  DiceThrow(this.count, this.dice);

  DiceThrow copyWith({int? count, Dice? dice, String? diceString}) {
    if (diceString != null) {
      final parts = diceString.split('d');
      return DiceThrow(int.parse(parts[0]), getDiceBySide(int.parse(parts[1])));
    }

    return DiceThrow(count ?? this.count, dice ?? this.dice);
  }

  @override
  String toString() {
    return '$count${diceToString(dice)}';
  }

  factory DiceThrow.fromMap(String diceString) {
    final parts = diceString.split('d');
    return DiceThrow(int.parse(parts[0]), getDiceBySide(int.parse(parts[1])));
  }
}
