import 'groq_usage.dart';

/// Usage statistics for compound AI completion requests.
/// Contains breakdown of usage by individual models.
///
class GroqUsageBreakdown {
  final List<GroqModelUsage> models;

  GroqUsageBreakdown({required this.models});

  factory GroqUsageBreakdown.fromJson(Map<String, dynamic> json) {
    return GroqUsageBreakdown(
      models: List<GroqModelUsage>.from(
        (json['models'] as List<dynamic>).map(
          (model) => GroqModelUsage.fromJson(model as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'models': models.map((model) => model.toJson()).toList(),
      };
}

/// Usage statistics for a specific model in a compound request.
class GroqModelUsage {
  final String model;
  final GroqUsage usage;

  GroqModelUsage({required this.model, required this.usage});

  factory GroqModelUsage.fromJson(Map<String, dynamic> json) {
    return GroqModelUsage(
      model: json['model'] as String,
      usage: GroqUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'model': model,
        'usage': usage.toJson(),
      };
}
