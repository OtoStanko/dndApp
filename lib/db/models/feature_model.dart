class Feature {
  int id;
  final String featureName;
  final String featureDescription;
  late final int featureMaxLevel;
  late final int featureUsed;
  final int featureLevelAcquire;
  final int featurePrimaryClass;

  Feature({
    required this.id,
    required this.featureName,
    required this.featureDescription,
    required this.featureMaxLevel,
    required this.featureUsed,
    required this.featureLevelAcquire,
    required this.featurePrimaryClass,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'featureName': featureName,
      'featureDescription': featureDescription,
      'featureMaxLevel': featureMaxLevel,
      'featureUsed': featureUsed,
      'featureLevelAcquire': featureLevelAcquire,
      'featurePrimaryClass': featurePrimaryClass
    };
  }

  Feature copyWith({
    int? id,
    String? featureName,
    String? featureDescription,
    int? featureMaxLevel,
    int? featureUsed,
    int? featureLevelAcquire,
    int? featurePrimaryClass,
  }) {
    return Feature(
      id: id ?? this.id,
      featureName: featureName ?? this.featureName,
      featureDescription: featureDescription ?? this.featureDescription,
      featureMaxLevel: featureMaxLevel ?? this.featureMaxLevel,
      featureUsed: featureUsed ?? this.featureUsed,
      featureLevelAcquire: featureLevelAcquire ?? this.featureLevelAcquire,
      featurePrimaryClass: featurePrimaryClass ?? this.featurePrimaryClass,
    );
  }

  factory Feature.fromMap(Map<String, dynamic> map) {
    print("Feature.fromMap: $map");
    return Feature(
        id: map['id'],
        featureName: map['featureName'],
        featureDescription: map['featureDescription'],
        featureMaxLevel: map['featureMaxLevel'],
        featureUsed: map['featureUsed'],
        featureLevelAcquire: map['featureLevelAcquire'],
        featurePrimaryClass: map['featurePrimaryClass']);
  }

  @override
  String toString() {
    return 'Feature{id: $id, featureName: $featureName, featureDescription: $featureDescription, featureMaxLevel: $featureMaxLevel, featureUsed: $featureUsed, featureLevelAcquire: $featureLevelAcquire, featurePrimaryClass: $featurePrimaryClass}';
  }
}
