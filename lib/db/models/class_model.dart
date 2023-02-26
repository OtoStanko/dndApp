class Class {
  int id;
  final String className;
  String classDescription;
  final int classHitDie;

  Class(
      {required this.id,
      required this.className,
      this.classDescription = '',
      required this.classHitDie});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'className': className,
      'classDescription': classDescription,
      'classHitDie': classHitDie
    };
  }

  Class copyWith(
      {int? id, String? className, String? classDescription, int? classHitDie}) {
    return Class(
        id: id ?? this.id,
        className: className ?? this.className,
        classDescription: classDescription ?? this.classDescription,
        classHitDie: classHitDie ?? this.classHitDie);
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
        id: map['id'],
        className: map['className'],
        classDescription: map['classDescription'],
        classHitDie: map['classHitDie']);
  }

  @override
  String toString() {
    return 'Class{id: $id, className: $className, classDescription: $classDescription, classHitDie: $classHitDie}';
  }
}
