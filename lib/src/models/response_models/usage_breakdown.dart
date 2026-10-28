import 'usage.dart';

/// Usage statistics for compound AI completion requests.
/// Contains breakdown of usage by individual models.
class GroqUsageBreakdown {
  /// List of models used in the request and their individual usage statistics.
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

class GroqModelUsage {
  /// The name/identifier of the model used
  final String model;

  /// Usage statistics for the completion request.
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
