import 'model.dart';

// Groq API Header Keys
final class ApiHeaderKeys {
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
}

// Groq API Header Values
final class ApiHeaderValues {
  static const String applicationJson = 'application/json';
  static String bearer(String key) {
    return 'Bearer $key';
  }
}

// Groq API Configuration model
final class GroqConfiguration {
  /// The model which will generate the completion.
  /// Some models are suitable for natural language
  /// tasks, others specialize in code.
  final GroqModel model;

  String get modelName => model.name;

  /// Controls randomness: lowering results in less
  /// random completions. As the temperature approaches
  /// zero, the model will become deterministic and repetitive.
  final double temperature;

  /// The maximum number of tokens to generate.
  /// Requests can use up to 32768 tokens shared between prompt and completion.
  final int maxTokens;

  /// Controls diversity via nucleus sampling: 0.5 means
  /// half of all likelihood-weighted options are considered.
  final double topP;

  /// Set if the request is via stream on request
  final bool stream;

  /// A stop sequence is a predefined or user-specified text string that
  /// signals an AI to stop generating content, ensuring its responses remain
  /// focused and concise. Examples include punctuation marks and markers
  /// like "[end]".
  final String? stop;

  // Response format can be used to specify the format of the response
  // JSON mode is a beta feature that guarantees all chat completions are valid JSON.
  // Set responseFormat to {"type": "json_object"} in your chat completion request for JSON mode.
  final Map<String, dynamic>? responseFormat;

  const GroqConfiguration({
    required this.model,
    this.temperature = 0.5,
    this.maxTokens = 1024,
    this.topP = 1.0,
    this.stream = false,
    this.stop,
    this.responseFormat,
  });
}
