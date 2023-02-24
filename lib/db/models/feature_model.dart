class Feature {
  int id;
  final String featureName;
  final String featureDescription;
  late final int featureMaxLevel;
  late final int featureUsed;

  Feature({
    required this.id,
    required this.featureName,
    required this.featureDescription,
    required this.featureMaxLevel,
    required this.featureUsed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'featureName': featureName,
      'featureDescription': featureDescription,
      'featureMaxLevel': featureMaxLevel,
      'featureUsed': featureUsed,
    };
  }

  Feature copyWith({
    int? id,
    String? featureName,
    String? featureDescription,
    int? featureMaxLevel,
    int? featureUsed,
  }) {
    return Feature(
      id: id ?? this.id,
      featureName: featureName ?? this.featureName,
      featureDescription: featureDescription ?? this.featureDescription,
      featureMaxLevel: featureMaxLevel ?? this.featureMaxLevel,
      featureUsed: featureUsed ?? this.featureUsed,
    );
  }

  @override
  String toString() {
    return 'Feature{id: $id, featureName: $featureName, featureDescription: $featureDescription, featureMaxLevel: $featureMaxLevel, featureUsed: $featureUsed}';
  }
}
