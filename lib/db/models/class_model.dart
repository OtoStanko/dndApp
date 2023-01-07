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

  @override
  String toString() {
    return 'Character{id: $id, className: $className, classDescription: $classDescription}';
  }
}
