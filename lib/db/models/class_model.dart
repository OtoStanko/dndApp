class Class {
  int id;
  final String className;
  final String classDescription;

  Class({
    required this.id,
    required this.className,
    required this.classDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'className': className,
      'classDescription': classDescription,
    };
  }

  Class copyWith({
    int? id,
    String? className,
    String? classDescription,
  }) {
    return Class(
      id: id ?? this.id,
      className: className ?? this.className,
      classDescription: classDescription ?? this.classDescription,
    );
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'],
      className: map['className'],
      classDescription: map['classDescription'],
    );
  }

  @override
  String toString() {
    return 'Character{id: $id, className: $className, classDescription: $classDescription}';
  }
}
