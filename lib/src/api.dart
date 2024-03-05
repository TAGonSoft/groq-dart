import 'model.dart';

final class ApiHeaderKeys {
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
}

final class ApiHeaderValues {
  static const String applicationJson = 'application/json';
  static String bearer(String key) {
    return 'Bearer $key';
  }
}

final class Configuration {
  final GroqModel model;
  String get modelName {
    switch (model) {
      case GroqModel.meta:
        return 'llama2-70b-4096';
      case GroqModel.mixtral:
        return 'mixtal-8x7b-32768';
    }
  }

  final double temperature;
  final int maxTokens;
  final double topP;
  final bool stream;
  final String? stop;

  Configuration({
    required this.model,
    this.temperature = 0.5,
    this.maxTokens = 1024,
    this.topP = 1.0,
    this.stream = false,
    this.stop,
  });
}
