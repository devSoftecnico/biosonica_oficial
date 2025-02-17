class ModelConfig {
  final String apiKey;
  final String model;
  final DateTime createdAt;
  final DateTime updatedAt;

  ModelConfig({
    required this.apiKey,
    required this.model,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModelConfig.fromJson(Map<String, dynamic> json) {
    return ModelConfig(
      apiKey: json['apiKey'] as String,
      model: json['model'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'model': model,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ModelConfig copyWith({
    String? apiKey,
    String? model,
    DateTime? updatedAt,
  }) {
    return ModelConfig(
      apiKey: apiKey ?? this.apiKey,
      model: model ?? this.model,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
