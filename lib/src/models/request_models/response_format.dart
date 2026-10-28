/// Response format configuration for Groq API.
///
/// An object specifying the format that the model must output.
/// Setting to { "type": "json_schema", "json_schema": {...} } enables
/// Structured Outputs which ensures the model will match your supplied
///  JSON schema. json_schema response format is only available on
/// supported models. Setting to { "type": "json_object" } enables the
/// older JSON mode, which ensures the message the model generates is
/// valid JSON. Using json_schema is preferred for models that support it.
///
/// Use one of the factory constructors to create a response format:
/// - [ResponseFormat.text] - Default text output
/// - [ResponseFormat.jsonObject] - Ensures valid JSON output
/// - [ResponseFormat.jsonSchema] - Structured output matching a JSON schema
sealed class ResponseFormat {
  const ResponseFormat();

  /// Default text response format.
  const factory ResponseFormat.text() = TextResponseFormat;

  /// JSON object response format.
  /// Ensures the model generates valid JSON.
  const factory ResponseFormat.jsonObject() = JsonObjectResponseFormat;

  /// JSON schema response format for structured outputs.
  /// The model will match your supplied JSON schema.
  const factory ResponseFormat.jsonSchema({
    required String name,
    required Map<String, dynamic> schema,
    String? description,
    bool? strict,
  }) = JsonSchemaResponseFormat;

  Map<String, dynamic> toNonNullMap();
}

final class TextResponseFormat extends ResponseFormat {
  const TextResponseFormat();

  @override
  Map<String, dynamic> toNonNullMap() => {'type': 'text'};
}

final class JsonObjectResponseFormat extends ResponseFormat {
  const JsonObjectResponseFormat();

  @override
  Map<String, dynamic> toNonNullMap() => {'type': 'json_object'};
}

final class JsonSchemaResponseFormat extends ResponseFormat {
  /// The name of the response format.
  /// Must be a-z, A-Z, 0-9, or contain underscores and dashes,
  /// with a maximum length of 64.
  final String name;

  /// The JSON schema that the model must match.
  final Map<String, dynamic> schema;

  /// A description of what the response format is for,
  /// used by the model to determine how to respond in the format.
  final String? description;

  /// Whether to enable strict schema adherence when generating the output.
  /// If set to true, the model will always follow the exact schema
  /// defined in the schema field. Only a subset of JSON Schema is
  /// supported when strict is true.
  final bool? strict;

  const JsonSchemaResponseFormat({
    required this.name,
    required this.schema,
    this.description,
    this.strict,
  });

  @override
  Map<String, dynamic> toNonNullMap() {
    final jsonSchemaMap = <String, dynamic>{
      'name': name,
      'schema': schema,
    };

    if (description != null) {
      jsonSchemaMap['description'] = description;
    }

    if (strict != null) {
      jsonSchemaMap['strict'] = strict;
    }

    return {
      'type': 'json_schema',
      'json_schema': jsonSchemaMap,
    };
  }
}
