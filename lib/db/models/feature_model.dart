class Feature {
  int id;
  final String featureName;
  final String featureDescription;
  final int featureMaxLevel;
  final int featureUsed;

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

  @override
  String toString() {
    return 'Feature{id: $id, featureName: $featureName, featureDescription: $featureDescription, featureMaxLevel: $featureMaxLevel, featureUsed: $featureUsed}';
  }
}
